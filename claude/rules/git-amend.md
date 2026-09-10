# Never amend without an explicit ask

Never run `git commit --amend` (or any other rewrite of an existing commit,
e.g. `git rebase -i` to reword/squash) unless the user has explicitly asked
for a specific commit to be amended, or has explicitly approved an amend you
proposed for that specific commit.

Do not infer it from context or treat it as the natural next step after
fixing a typo, addressing review feedback, fixing a failed pre-commit hook,
or otherwise "cleaning up" a commit — none of those imply permission to
amend. Default to creating a new commit instead. An amend approved earlier in
the conversation does not carry forward; each amend needs its own explicit
ask, scoped to the commit it was approved for.

If a task seems to call for an amend but the user hasn't said so, stop and
ask (naming the target commit) rather than doing it.
