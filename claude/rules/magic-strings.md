# Avoid magic strings: name them as constants

Don't leave a string literal inline when it's used for branching logic
(equality checks, `switch`/`match`, discriminated union tags, etc.) or when
it's repeated in more than one place. Give it a named constant instead.

- Group related constants into an enum-style structure (a TS `enum`, a
  `const` object with `as const`, a Python `Enum`/`StrEnum`, etc. — whatever
  idiom fits the language) rather than scattered standalone constants, when
  the values are clearly members of one set.
- Define it in an appropriate constants module when one exists, or when one
  naturally fits (e.g. shared status/type values used across files). If
  nothing fits, keep it near the value's natural owner (e.g. co-located with
  the type it backs) rather than inline at the first call site that needed
  it. If no constants module exists yet but the value warrants one (or more
  values are likely to join it), it's fine to create one — use judgment on
  when that's justified.
- This applies even when a TypeScript union type (or similar) already
  constrains a field to a fixed set of strings. That type gives you
  compile-time safety, not a reusable name — still back the values with
  named constants instead of repeating the literals at each use site.

This rule's requirement (branching logic or repeated in more than one place)
doesn't extend to a string used exactly once and never compared against as
branching logic (a one-off log message, an error message, UI copy) — but
that's just the floor. There can still be good reason to name a single-use
string as a constant (e.g. clarifying intent, anticipating reuse); this rule
just doesn't mandate it for that case.
