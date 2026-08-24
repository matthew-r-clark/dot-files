---
paths:
  - "**/*.test.js"
  - "**/*.test.jsx"
  - "**/*.test.mjs"
  - "**/*.test.cjs"
  - "**/*.test.ts"
  - "**/*.test.tsx"
  - "**/*.spec.js"
  - "**/*.spec.jsx"
  - "**/*.spec.mjs"
  - "**/*.spec.cjs"
  - "**/*.spec.ts"
  - "**/*.spec.tsx"
  - "**/__tests__/**/*.js"
  - "**/__tests__/**/*.jsx"
  - "**/__tests__/**/*.mjs"
  - "**/__tests__/**/*.cjs"
  - "**/__tests__/**/*.ts"
  - "**/__tests__/**/*.tsx"
  - "**/*.bats"
  - "**/*_spec.lua"
  - "**/*_test.lua"
---

# Automated unit tests: what to cover, and how to decide

Never write test cases that exercise a third-party dependency's or a
built-in/standard-library module's own behavior — that coverage belongs to
that dependency, not this codebase. Test how *your* code uses it, not that it
itself works.

Don't add a test case for the sake of coverage. Skip anything not necessary
to the change at hand, and skip anything another existing test case already
covers.

Before adding a given test case, spawn two subagents with the Agent tool, in
parallel:

- **For**: argue why this specific test case is necessary — what real
  behavior or regression it would catch that nothing else covers.
- **Against**: argue why it should be dropped — because it exercises a
  third-party/built-in module, duplicates existing coverage, or tests
  something that isn't necessary.

Act as the orchestrator: weigh both arguments and decide whether to write the
test case as proposed or drop it. Do this per test case, not once for the
whole suite.

When writing JavaScript/TypeScript tests, generate test data with
`@faker-js/faker` instead of hardcoding values, except where a specific
literal value is the point of the test (e.g. asserting a validator rejects
exactly `""`). Store whatever test data you do write out — generated or
literal — in named consts, rather than repeating magic strings/values inline
throughout the test file.
