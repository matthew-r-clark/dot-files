---
name: pre-pr-assessment
description: Review local branch changes for bugs, logic errors, code quality, and platform style violations before a PR is created. Invoked explicitly via /pre-pr-assessment.
argument-hint: "<branch> [<base-branch>] [<service>]"
disable-model-invocation: true
---

# Pre-PR Assessment

Input: $ARGUMENTS

---

## Step 1 — Parse Input

Determine what was provided. Accepted forms:

| Form | Example |
|---|---|
| Branch only (compare to default) | `feature/BNC-3649-shipping-form` |
| Branch + base branch | `feature/BNC-3649-shipping-form master` |
| Branch + service name | `feature/BNC-3649-shipping-form checkoutdwa` |
| Branch + base branch + service | `feature/BNC-3649-shipping-form master checkoutdwa` |

**Defaults:**
- Base branch: `master` (fall back to `main` if `master` doesn't exist)
- Service/repo: current working directory

If the input is blank, use `AskUserQuestion` to ask:
- What branch should be reviewed?
- What base branch should it be compared against (or accept the default)?
- Which service or repo (if not running from within the repo)?

---

## Step 2 — Resolve the Repository

If a service name was provided, use the service registry to find the correct repo location:

```
mcp__registry__search_services(query="<service-name>")
ReadMcpResourceTool(server="registry", uri="registry://service/<name>")
```

Confirm the repo is cloned at `projects/<service>/` (relative to `od-env` root). If not, inform the user and stop.

If no service was provided, assume the current working directory is the repo root.

---

## Step 3 — Determine the Base Branch

If no base branch was specified, detect the default:

```bash
git remote show origin | grep 'HEAD branch'
```

Fall back to `master`, then `main`, if the above fails. Confirm the base branch exists locally or on origin before proceeding.

---

## Step 4 — Get the Diff

Fetch the review branch and produce the diff against the base branch:

```bash
git fetch origin <branch>
git fetch origin <base-branch>
git diff origin/<base-branch>...FETCH_HEAD
```

If the branch is already checked out locally, `FETCH_HEAD` can be replaced with the local branch name.

The diff may be large. Read it in chunks if needed. Do not truncate — review the complete diff.

Also capture the commit log for context:

```bash
git log origin/<base-branch>..FETCH_HEAD --oneline
```

---

## Step 5 — Contextual Review

With the diff and full codebase available, review for the following. For each issue found, record the **file path**, **line number(s)**, the **offending code snippet**, and a clear explanation.

### 5a. Logic and Correctness
- Boolean conditions inverted or negated incorrectly
- Off-by-one errors, boundary conditions
- State mutations with wrong values (e.g. `setState(false)` when `true` was intended)
- Async/await misuse, missing `await`, unhandled promise rejections
- Early returns or fallthrough that skip required logic

### 5b. Null and Type Safety
- Property access on values that could be `null` or `undefined`
- Missing guards before `.map()`, `.filter()`, `.forEach()` on potentially-absent arrays
- Implicit type coercion producing surprising results
- In TypeScript services: `interface` or `type` declarations that duplicate a Zod schema instead of using `z.infer<typeof schema>`

### 5c. Syntax and Parse Errors
- Mismatched quotes or brackets in template literals and CSS-in-JS
- Invalid JSX, unclosed tags
- Expressions that will throw a SyntaxError or runtime TypeError

### 5d. Dead and Debug Code
- Commented-out code blocks left in
- `console.log`, `console.error`, or `console.warn` statements (production code must use `@odyssey/logger`)
- `debugger` statements
- Unused imports, variables, or props introduced in this branch

### 5e. Test Quality
- Tests simplified to the point of losing meaningful assertion specificity (e.g. checking a count instead of the actual message text)
- Missing tests for new branches or edge cases introduced by the changes
- Assertions on mock call counts when the call itself is not the behavior under test
- Testing implementation details rather than outcomes (input → output)
- Broken test setup: missing providers, mocks that don't reflect real behavior
- Database layer mocked instead of using real instances (Testcontainers) in integration tests
- Outbound HTTP to upstream services mocked at the wrong boundary (should use MSW, not manual stubs)

### 5f. Platform Style Guide Violations

Apply these based on the service type. Check the changed files to determine whether this is a backend service (`*api`, `*proc`) or a frontend app (`*dwa`, `*web`).

**Logging (all services):**
- `console.log`, `console.error`, `console.warn` must not appear in production code — flag as Critical
- Dynamic data must go in the context object, not interpolated into the message string:
  - Wrong: `logger.info(\`Vehicle ${vehicleId} processed\`)`
  - Right: `logger.info({ vehicleId }, 'Vehicle processed')`

**Config access (backend services):**
- `process.env` must not be accessed directly in application code — use `config.get('path.to.key')`
- Config files must stay `module.exports = {}` (CommonJS), even in TypeScript services

**Immutability (backend services):**
- Plain object mutation (`obj.key = value`) is forbidden outside Mongoose document hooks
- Transformations should use `assoc`, `dissoc`, `evolve`, `mergeRight`, `omit`, `assocPath`

**Classes and factories (backend services):**
- `class` is only permitted for named error types (`class FooError extends Error {}`)
- DI modules must use factory functions `({ dep1, dep2 }) => ({ method1, method2 })`, not classes with methods
- Single-use modules instantiated once at startup should not be wrapped in factories — import config at module level and export functions directly

**Control flow (backend services):**
- `switch` statements are not permitted — use `cond([[pred, fn], ...])` for 3+ branches
- Nested ternary expressions are not permitted
- 3+ if/else branches should use `cond()` with named predicate functions

**Function naming contracts (backend services):**
- `compute*`, `calculate*`, `build*`, `is*`, `has*` — must be pure; flag any I/O (DB call, HTTP call, event publish) inside these
- `get*`, `fetch*`, `send*`, `publish*`, `save*` — expected to be side-effectful

**Module imports (backend services):**
- TypeScript services: internal modules use `#*` subpath imports
- Legacy JS services: internal pseudo-packages use `@@` aliases, never relative paths
- `require()` must not appear in TypeScript source files (except config files)
- `import` must not appear in config files

**HTTP and outbound calls (backend services):**
- Use `@odyssey/config.rest` (the `got` wrapper) for all outbound HTTP to Odyssey services — not raw `fetch` or `axios`
- HTTP status constants from `@odyssey/base-api` (`OK`, `NOTFOUND`, etc.) should be used in CJS services that already import the library; raw numbers are acceptable in ESM-only TypeScript services where the interop cost is too high

**Functional utilities (backend services):**
- New code should use Ramda functional utilities (`pipe`, `cond`, `evolve`, `assoc`), not Lodash
- Do not introduce new Lodash imports; if a file already uses Lodash, add new code in the functional utility style without replacing existing Lodash calls

**Naming conventions (all services):**
- Files: kebab-case, except `PascalCase.jsx` for React components
- Variables and functions: camelCase
- Mongoose model constructors: PascalCase
- `UPPER_SNAKE_CASE` only for exported enum-like discriminators, not regular `const` bindings inside functions

**Gradual modernization (all services):**
- Changes must match the file's existing style — do not migrate a file from CJS to ESM or Mocha to Vitest as part of a feature/bugfix PR
- Style migration belongs in a dedicated PR, not mixed into functional changes

---

## Step 6 — Report Findings

Present a structured report. Lead with a brief summary (one or two sentences describing what the branch changes do, inferred from the diff and commit log), then list all findings grouped by severity. Omit any severity section that has no findings.

```
## Pre-PR Assessment — <branch-name>
**Repo:** <service/repo>  |  **Diff:** <branch> → <base-branch>  |  **Commits:** <N>

<One-sentence summary of what this branch does.>

---

### Critical — Must Fix Before Raising PR

#### 1. <Short title>
**File:** `path/to/file.jsx` — **Line <N>**
```
<offending code snippet>
```
**Issue:** <Clear explanation of the bug and why it's wrong.>
**Fix:** <Concrete suggestion.>

---

### Major — Should Fix

#### 2. <Short title>
**File:** `path/to/file.js` — **Lines <N>–<M>**
...

---

### Minor — Low Priority

#### 3. <Short title>
**File:** `path/to/file.js` — **Line <N>**
...

---

### No Issues Found
This branch looks clean — no glaring issues identified. Safe to raise a PR.
```

**Severity guide:**

| Severity | Meaning |
|---|---|
| Critical | Will break at runtime, produce incorrect behavior, or violates a non-negotiable platform rule (no `console.log`, no direct `process.env`, no object mutation outside Mongoose) |
| Major | Logic flaw, test regression, or pattern that will cause problems under real conditions |
| Minor | Dead code, style inconsistency, weak assertion, gradual-modernization violation — doesn't affect correctness today |

---

## Step 7 — Offer to Implement Fixes

If any findings were reported, use `AskUserQuestion` to ask:

> Would you like me to implement any of these fixes? If so, which ones — all of them, just the Critical/Major issues, or specific items by number?

If the user says yes (all or some):
- Work through each selected fix in the order they were reported
- Edit the files directly on the review branch (confirm it is checked out first; if not, check it out before making changes)
- After all edits are complete, summarise what was changed and remind the user to re-run tests before raising the PR

If the user declines or there were no findings, end the session.
