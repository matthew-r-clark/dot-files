# Code comments: debate before writing

Default to no comment. Well-named identifiers and clear structure should carry
the explanation; comments are the exception, not the norm.

This rule does not apply to code you are removing or code-removal explanations
("// removed X") — those are simply disallowed, no debate needed.

Before writing a comment to explain genuinely non-obvious code (a hidden
constraint, a subtle invariant, a workaround for a specific bug, behavior that
would surprise a reader), spawn two subagents with the Agent tool, in
parallel:

- **For**: argue why this specific comment should be written, with the exact
  wording proposed.
- **Against**: argue why it should be omitted (or shortened), critiquing the
  proposed wording directly.

Act as the orchestrator: weigh both arguments and decide whether to write the
comment as proposed, write a shortened version informed by the "against"
critique, or omit it entirely. Do this for every comment you write, not just
ones you're unsure about.

**No long single-line comments.** A single-line `/** ... */` is only for
comments that are actually short. Once the wording needs a full sentence with
its own internal clause or parenthetical, wrap it as a multiline block
instead of collapsing it onto one long line — a long single-line comment
isn't shorter, it's just harder to scan, and its length is usually a sign the
wording itself still needs trimming from the debate above, not merely
reformatting.
