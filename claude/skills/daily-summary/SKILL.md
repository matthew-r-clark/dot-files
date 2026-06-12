---
name: daily-summary
description: Aggregates today's activity from Jira, Bitbucket, and Slack into a standup-ready summary. Invoked via /daily-summary.
argument-hint: "[YYYY-MM-DD] [today: plan item 1, plan item 2, ...]"
disable-model-invocation: true
---

# Daily Activity Summary

Input: $ARGUMENTS

---

## Step 1 — Parse Input

**Date range:**

- If a `YYYY-MM-DD` date is present in the arguments, the range is that full calendar day (midnight to midnight).
- If no date is provided, the range is **yesterday at 9:30 AM Central Time through the current moment**. Central Time is UTC−5 in summer (CDT) and UTC−6 in winter (CST) — determine which applies based on today's date (CDT is active from the second Sunday of March through the first Sunday of November).

Compute two values and use them in all queries below:
- `RANGE_START`: yesterday's date + `T14:30:00Z` (CDT) or `T15:30:00Z` (CST) in ISO 8601 UTC
- `RANGE_START_DATE`: yesterday's date as `YYYY-MM-DD` (used where only a date is accepted)
- `RANGE_START_UNIX`: `RANGE_START` expressed as a Unix timestamp (seconds since epoch), for Slack's `after` parameter

**Today's plans:** If the arguments contain a `today:` section (e.g. `today: finish the auth PR, review BNC-1234`), extract each item as a separate plan bullet. Otherwise leave today's plans empty — do not infer or fabricate them.

---

## Step 2 — Parallel Data Collection

Run all three queries concurrently.

### 2a. Jira Activity

Run two JQL queries in parallel:

**Query 1 — Issues the user owns that were updated in range:**
```
mcp__roadie__search_jira_issues(
  jql="(assignee = currentUser() OR reporter = currentUser()) AND updated >= \"<RANGE_START_DATE> 09:30\" ORDER BY updated DESC",
  max_results=50
)
```

**Query 2 — Issues where the user transitioned status in range:**
```
mcp__roadie__search_jira_issues(
  jql="status changed BY currentUser() AFTER \"<RANGE_START_DATE> 09:30\" ORDER BY updated DESC",
  max_results=50
)
```

Note: Jira interprets unzoned datetimes in the instance's configured timezone. `09:30` on `RANGE_START_DATE` is used as an approximation; results within a timezone-offset margin of the true start are acceptable.

Merge and deduplicate by issue key. For each issue record: key, summary, status, and project key (e.g. `BNC`, `TLO`).

### 2b. Slack Activity

Search for messages sent by the user today:

```
mcp__claude_ai_Slack__slack_search_public_and_private(
  query="from:<@U01JVLMFRLN> after:<RANGE_START_DATE>",
  after="<RANGE_START_UNIX>",
  sort="timestamp",
  sort_dir="desc",
  limit=20,
  include_context=false
)
```

Group results by channel. For each channel, note the message count and a brief excerpt of the most substantive message (skip one-word replies and emoji-only messages).

### 2c. Bitbucket Activity

Use the Jira project keys from Step 2a to determine which Bitbucket project(s) to check.

**Project key mapping** (Jira → Bitbucket):

| Jira project prefix | Bitbucket project key |
|---|---|
| BNC, BOU | `bou` |
| TLO | `tlo` |
| WRK | `wrk` |

For each Bitbucket project key identified, list its repositories:
```
mcp__roadie__list_repositories(project_key="<bitbucket-key>")
```

Then, for each repository in those projects, list recent PRs:
```
mcp__roadie__list_pull_requests(
  project_key="<bitbucket-key>",
  repository_slug="<slug>",
  state="ALL",
  limit=10
)
```

From the results, keep only PRs where:
- The author display name is `Matthew Clark`, AND
- The PR was created OR last updated on the target date

If no Jira activity was found, or if the Jira project keys don't map to any known Bitbucket project, note "No Bitbucket repos identified from Jira activity" and skip this section.

**Personal repos (always check, regardless of Jira activity):**

Also check the user's personal Bitbucket project (`~clarkm`) unconditionally:

```
mcp__roadie__list_repositories(project_key="~clarkm")
```

For each personal repo returned, list recent PRs and commits using whichever project key succeeded:
```
mcp__roadie__list_pull_requests(
  project_key="~clarkm",
  repository_slug="<slug>",
  state="ALL",
  limit=10
)
```

```
mcp__roadie__get_commits(
  project_key="~clarkm",
  repository_slug="<slug>",
  limit=10
)
```

From the PR results, keep PRs where the author is `Matthew Clark` and created/updated at or after `RANGE_START`.
From the commit results, keep commits where the author email is `matthew.clark@taillight.com` and the commit timestamp is at or after `RANGE_START`.

If `~clarkm` returns a 404 or "project not found" error, silently skip the personal repos section.

---

## Step 3 — Synthesize Summary

Produce a standup-style summary using all data gathered. Synthesize across sources — a Jira ticket, its associated PR, and related Slack discussion should appear as a single "Yesterday" bullet, not three separate ones.

Output format:

```
Yesterday:
- Worked on [KEY-123] — brief description of what was done
- Opened/merged PR "title" in repo-name
- Discussed X in #channel-name
- (etc. — one bullet per meaningful unit of work)

Today:
- Plan item 1 (from arguments)
- Plan item 2 (from arguments)
```

**Yesterday:** One bullet per meaningful unit of work. Combine related signals (Jira ticket + PR + Slack thread = one bullet). Use plain language, not ticket IDs or PR numbers as the primary label — mention them parenthetically if useful. If there was no activity, write `- No activity.`

**Today:** Include a bullet for each item provided in the arguments. If no items were provided and none can be clearly determined from the data (e.g. an open PR or an in-progress Jira ticket that obviously continues tomorrow), write only the `Today:` header with no bullets.

Do not include any other headers, preamble, or narrative outside this structure.
