---
description: Pull every REC ticket assigned to Dylan in "REFERRED TO PRODUCT OWNER" status, investigate each one read-only against Salesforce data + code, and (after approval) post root-cause findings as a Jira comment.
argument-hint: (no arguments — runs over Dylan's current backlog)
---

# /daily-triage

You are running the daily PO support triage. The job: surface every REC ticket currently sitting on Dylan in `REFERRED TO PRODUCT OWNER`, investigate it read-only, and post a root-cause hypothesis as an internal Jira comment once Dylan approves the wording.

This command is **manual-trigger only** during POC. Do not auto-schedule it. Do not loop.

## Inputs

None. You discover the work via JQL.

## Process — follow in order

### Step 1 — Fetch the backlog

Call `mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql` with:

- `cloudId`: `df687131-f34f-4706-94fb-fb07dc1f8ece`
- `jql`:
  ```
  project = REC AND status = "REFERRED TO PRODUCT OWNER" AND assignee = "712020:b0fb0d8e-3d44-492a-8e38-53b0a39de1aa" ORDER BY updated DESC
  ```
- `fields`: `summary, status, priority, reporter, created, updated, description, comment, issuelinks, labels`

If the JQL returns zero results, **do not assume the queue is empty**. The status label may differ from `REFERRED TO PRODUCT OWNER` (Dylan also calls it `REC-REFERRED TO PRODUCT OWNER`). Re-run with `status = "REC-REFERRED TO PRODUCT OWNER"` and, if still empty, fetch all REC issues assigned to Dylan updated in the last 7 days and ask Dylan to point you at the canonical status value. Save the confirmed value to `MEMORY.md` for next run.

### Step 2 — Present the list

Show Dylan a compact table:

| # | Key | Summary | Priority | Updated | Reporter |
|---|-----|---------|----------|---------|----------|

Then ask via `AskUserQuestion`: "Which tickets should I investigate?" Options:
- **All** (default, recommended)
- **Subset** — Dylan picks numbers
- **Skip** — abort the run

### Step 3 — Spawn investigators in parallel (max 3 concurrent)

For each chosen ticket, launch a `ticket-investigator` subagent (via the Agent tool, `subagent_type: ticket-investigator`). Send up to 3 in a single message to run in parallel; if there are more than 3, wait for the batch and send the next.

Prompt template for each subagent:

```
Investigate Jira ticket <KEY>.

Full ticket payload (from searchJiraIssuesUsingJql):
<paste the issue JSON for this one ticket>

Today's date: <YYYY-MM-DD>
Findings file (write your final markdown here): investigations/<YYYY-MM-DD>/<KEY>.md

Follow your subagent instructions exactly. Read-only on Salesforce and code. Produce the standard findings markdown and write it to the file above. Return the markdown content as your final message so I can show it to Dylan.
```

### Step 4 — Review with Dylan, one ticket at a time

For each completed investigation:

1. Show Dylan the findings markdown.
2. Use `AskUserQuestion` with options:
   - **Post to Jira** (recommended) — call `mcp__claude_ai_Atlassian__addCommentToJiraIssue` with the markdown as the comment body. Confirm the comment ID came back.
   - **Edit first** — Dylan dictates changes; you update the file and re-ask.
   - **Skip** — do not post; note the reason in the summary.
   - **Blocked — needs info from reporter** — do not post; draft a separate "questions for reporter" note for Dylan to send manually.

Do **not** batch-post. Each ticket gets its own gate.

### Step 5 — Write run summary

Create `investigations/<YYYY-MM-DD>/_summary.md`:

```markdown
# Daily Triage — <YYYY-MM-DD>

**Run started:** <HH:MM>
**Tickets in queue:** <N>
**Investigated:** <N>

| Key | Status | Notes |
|-----|--------|-------|
| REC-1234 | posted | comment id 1023456 |
| REC-1235 | skipped | duplicate of REC-1100 |
| REC-1236 | blocked | needs reproduction steps from reporter |
```

If you spotted any cross-ticket patterns (multiple tickets pointing at the same component, same recent deploy, same data anomaly), add an `_observations.md` alongside. Keep it short — bullet points, not prose.

### Step 6 — End

Print the one-line-per-ticket roll-up to chat and stop. Do not transition tickets. Do not edit Jira fields. Do not commit anything to git.

## Failure modes — handle gracefully

- **Atlassian MCP unreachable** → stop, tell Dylan, suggest checking `.env` and the `atlassian` SSE URL.
- **`sf` CLI not authed** → the subagent will surface this; show Dylan the exact `sf org login web -a <alias>` command and stop the affected investigation, continue with the rest.
- **GitHub-Salesforce MCP returns nothing on a repo search** → record "no code evidence found" in the finding rather than fabricating a file path.
- **A subagent returns hallucinated SOQL or invented field names** → the subagent prompt forbids this, but if it slips through, do not post; flag it back to Dylan as "investigation rejected — re-run".

## Rules recap

- Read-only on Salesforce data and code.
- Only Jira write is `addCommentToJiraIssue`, gated per-ticket by `AskUserQuestion`.
- Cite evidence for every claim.
- One ticket at a time at the review gate.
- No git commits.
