---
name: pr-review
description: Review a pull request and post findings as comments directly to the Bitbucket PR via the roadie MCP server. Presents proposed comments for user approval before posting. Invoked explicitly via /pr-review.
argument-hint: "<pr-number> <repo-or-service> | <ticket-number> | <branch-name>"
disable-model-invocation: true
---

# PR Review

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

Use the service registry to find the correct Bitbucket project key and repo slug.

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
- Tests simplified to the point of losing meaningful assertion specificity
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
- Dynamic data must go in the context object, not interpolated into the message string

**Config access (backend services):**
- `process.env` must not be accessed directly in application code — use `config.get('path.to.key')`
- Config files must stay `module.exports = {}` (CommonJS), even in TypeScript services

**Immutability (backend services):**
- Plain object mutation (`obj.key = value`) is forbidden outside Mongoose document hooks
- Transformations should use `assoc`, `dissoc`, `evolve`, `mergeRight`, `omit`, `assocPath`

**Classes and factories (backend services):**
- `class` is only permitted for named error types (`class FooError extends Error {}`)
- DI modules must use factory functions, not classes with methods

**Control flow (backend services):**
- `switch` statements are not permitted — use `cond([[pred, fn], ...])` for 3+ branches
- Nested ternary expressions are not permitted
- 3+ if/else branches should use `cond()` with named predicate functions

**Function naming contracts (backend services):**
- `compute*`, `calculate*`, `build*`, `is*`, `has*` — must be pure; flag any I/O inside these
- `get*`, `fetch*`, `send*`, `publish*`, `save*` — expected to be side-effectful

**Module imports (backend services):**
- TypeScript services: internal modules use `#*` subpath imports
- Legacy JS services: internal pseudo-packages use `@@` aliases, never relative paths
- `require()` must not appear in TypeScript source files (except config files)

**HTTP and outbound calls (backend services):**
- Use `@odyssey/config.rest` (the `got` wrapper) for all outbound HTTP to Odyssey services

**Functional utilities (backend services):**
- New code should use Ramda functional utilities, not Lodash

**Naming conventions (all services):**
- Files: kebab-case, except `PascalCase.jsx` for React components
- Variables and functions: camelCase
- `UPPER_SNAKE_CASE` only for exported enum-like discriminators

**Gradual modernization (all services):**
- Changes must match the file's existing style — do not migrate a file from CJS to ESM as part of a feature/bugfix PR

---

## Step 6 — Compile Proposed Comments

Group all findings into a list of proposed PR comments. Each proposed comment must include:

- **#** — sequential number
- **Severity** — Critical / Major / Minor
- **File** — path relative to repo root
- **Line(s)** — specific line number(s) from the diff
- **Snippet** — the offending code (1–5 lines)
- **Comment text** — the full text that will be posted to the PR (written as if addressing the author directly; be constructive and specific)

If no issues were found, skip to Step 8 and inform the user there is nothing to post.

---

## Step 7 — Present Proposed Comments for Approval

### 7a. Show the table

Display ALL proposed comments in a markdown table:

```
| # | Severity | File | Line(s) | Issue Summary |
|---|---|---|---|---|
| 1 | Critical | src/foo/bar.js | 42 | Missing null guard before .map() |
| 2 | Major | src/baz/qux.ts | 87–91 | console.log in production path |
| 3 | Minor | src/foo/bar.js | 15 | Unused import `lodash` |
```

Then show the full text for each proposed comment in a numbered list beneath the table.

### 7b. Ask for confirmation

Use `AskUserQuestion` to ask:

> These are the proposed PR comments. What would you like to do?
>
> - **post** — post all comments as-is
> - **edit** — review and edit comments one by one
> - **cancel** — abort without posting anything

### 7c. Handle "edit" response

If the user says **edit** (or indicates they want to change something), cycle through each proposed comment one at a time using `AskUserQuestion`:

For each comment N of total:

> **Comment [N/total] — [Severity] — [File]:[Lines]**
>
> Current text:
> ```
> [current comment text]
> ```
>
> Options:
> - Type a replacement to reword this comment
> - Type **keep** to leave it unchanged
> - Type **drop** to remove it from the list

Apply the user's response (replace text, keep, or remove from list), then move to the next comment.

After cycling through all comments, show the updated table again (Step 7a), then proceed to Step 7d.

### 7d. Final confirmation

Use `AskUserQuestion` for a final confirmation before posting:

> Ready to post [N] comment(s) to PR #[number] ([repo]):
>
> [list each comment: severity, file, line(s), first line of text]
>
> Type **yes** to post, or **no** to cancel.

If the user says **no**, abort and inform them that no comments were posted.

---

## Step 8 — Post Comments

For each approved comment, post it as an **inline comment** anchored to the specific file and line using:

```
mcp__roadie__add_inline_pr_comment(
  project_key: "<project-key>",
  repository_slug: "<repo-slug>",
  pr_id: <pr-number>,
  comment: "<comment text>",
  path: "<file path relative to repo root>",
  line: <line number>,
  line_type: "ADDED" | "REMOVED" | "CONTEXT",
  file_type: "TO" | "FROM"
)
```

**Choosing `line_type` and `file_type`:**

| Situation | `line_type` | `file_type` |
|---|---|---|
| Commenting on a new/added line | `ADDED` | `TO` |
| Commenting on a deleted line | `REMOVED` | `FROM` |
| Commenting on an unchanged context line | `CONTEXT` | `TO` |

When in doubt, use `ADDED` / `TO` — this is the most common case and works for the majority of review comments on new code.

**Comment text format:**

Keep the comment text concise and direct — it will appear inline next to the code in Bitbucket, so no need to repeat the file or line number. Use this structure:

```
[Critical] <short issue title>

<explanation of the problem and why it's wrong>

Suggestion: <concrete fix>
```

Post comments one at a time. After each, confirm the call succeeded before moving to the next.

---

## Step 9 — Summary

After all comments are posted, display a brief summary:

```
## PR Review Complete — PR #<number> (<repo>)

Posted <N> comment(s):
- ✓ [Critical] src/foo/bar.js:42 — Missing null guard
- ✓ [Major] src/baz/qux.ts:87 — console.log in production
- ✓ [Minor] src/foo/bar.js:15 — Unused import

View PR: <PR URL from Step 3>
```

If any comment failed to post, list the failures and suggest the user post them manually.
