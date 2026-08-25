# Never push without an explicit ask

Never run `git push` (including `--force`/`--force-with-lease`) unless the
user has explicitly asked for a push in that specific request.

Do not infer it from context or treat it as the natural next step after a
commit, PR creation, or otherwise "finishing" a task — committing, creating a
branch, or opening a PR does not imply permission to push. A push approved
earlier in the conversation does not carry forward; each push needs its own
explicit ask.

If a task seems to call for a push but the user hasn't said so, stop and ask
rather than doing it.
