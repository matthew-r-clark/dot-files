# Automated unit tests: what to cover, and how to decide

Never write test cases that exercise a third-party dependency's or a
built-in/standard-library module's own behavior — that coverage belongs to
that dependency, not this codebase. Test how *your* code uses it, not that it
itself works.

Don't add a test case for the sake of coverage. Skip anything not necessary
to the change at hand, and skip anything another existing test case already
covers.

Before adding test cases, first collect the full list of candidates you're
considering for the change at hand. Then spawn exactly two subagents with the
Agent tool, in parallel, each given the whole list:

- **For**: for every candidate, argue why that specific test case is
  necessary — what real behavior or regression it would catch that nothing
  else covers.
- **Against**: for every candidate, argue why it should be dropped — because
  it exercises a third-party/built-in module, duplicates existing coverage,
  or tests something that isn't necessary.

Act as the orchestrator: weigh both arguments per candidate and decide, for
each one individually, whether to write it as proposed or drop it — one
For/Against pair covering the whole batch, not one pair per test case.

When writing JavaScript/TypeScript tests, generate test data with
`@faker-js/faker` instead of hardcoding values, except where a specific
literal value is the point of the test (e.g. asserting a validator rejects
exactly `""`). Store whatever test data you do write out — generated or
literal — in named consts, rather than repeating magic strings/values inline
throughout the test file.
