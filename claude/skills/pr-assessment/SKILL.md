---
name: pr-assessment
description: Review a pull request for bugs, logic errors, code quality, and platform style violations. Invoked explicitly via /pr-assessment.
argument-hint: "<pr-number> <repo-or-service> | <ticket-number> | <branch-name>"
disable-model-invocation: true
---

# PR Assessment

Input: $ARGUMENTS

---

## Step 1 — Parse Input

Determine what was provided. Accepted forms:

| Form | Example |
|---|---|
| PR number + service/repo name | `38 checkoutdwa` or `38 checkout-dwa` |
| PR number alone (ask for repo) | `38` |
| Jira ticket number | `BNC-3649` |
| Branch name | `feature/BNC-3649-shipping-form` |

If the input is blank or ambiguous, use `AskUserQuestion` to ask:
- What is the PR number (or ticket/branch)?
- Which repo or service does it belong to?

---

## Step 2 — Resolve the Repository

Use the service registry to find the correct Bitbucket project key and repo slug. The service name in the registry may differ from the Bitbucket repo slug (e.g. `checkoutdwa` → `checkout-dwa`).

```
mcp__registry__search_services(query="<service-name>")
ReadMcpResourceTool(server="registry", uri="registry://service/<name>")
```

This returns `bitbucket_project` (e.g. `bou`, `tlo`, `wrk`) and `repo` (the SSH URL containing the slug).

If the service cannot be found via the registry, ask the user for the Bitbucket project key and exact repo slug before continuing.

---

## Step 3 — Fetch PR Details

Call `mcp__roadie__get_pull_request` with the resolved project key, repo slug, and PR number.

From the response, extract:
- **From branch** (the PR branch)
- **Target branch** (usually `master`)
- **PR title and description** — keep this for context during review
- **Author**

If only a ticket number or branch was provided, use `mcp__roadie__list_pull_requests` or `mcp__roadie__search_jira_issues` to find the associated PR number first.

---

## Step 4 — Get the Diff Locally

A local diff gives access to the full codebase for context — file history, related modules, tests, etc.

1. Confirm the repo is cloned at `projects/<service>/` (relative to `od-env` root). If not, inform the user.

2. Fetch the PR branch:
   ```bash
   cd projects/<service>
   git fetch origin <from-branch>
   ```

3. Produce the diff against the target branch:
   ```bash
   git diff origin/<target-branch>...FETCH_HEAD
   ```

The diff may be large. Read it in chunks if needed. Do not truncate — review the complete diff.

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
- Unused imports, variables, or props introduced in this PR

### 5e. Test Quality
- Tests simplified to the point of losing meaningful assertion specificity (e.g. checking a count instead of the actual message text)
- Missing tests for new branches or edge cases introduced by the PR
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

Present a structured report. Lead with a brief summary (one or two sentences about the PR's purpose), then list all findings grouped by severity. Omit any severity section that has no findings.

```
## PR Assessment — <PR Title> (#<number>)
**Repo:** <project>/<slug>  |  **Branch:** <from-branch> → <target-branch>  |  **Author:** <author>

<One-sentence summary of what this PR does.>

---

### Critical — Must Fix Before Merge

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
This PR looks clean — no glaring issues identified.
```

**Severity guide:**

| Severity | Meaning |
|---|---|
| Critical | Will break at runtime, produce incorrect behavior, or violates a non-negotiable platform rule (no `console.log`, no direct `process.env`, no object mutation outside Mongoose) |
| Major | Logic flaw, test regression, or pattern that will cause problems under real conditions |
| Minor | Dead code, style inconsistency, weak assertion, gradual-modernization violation — doesn't affect correctness today |
