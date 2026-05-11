# Support Agent

A Claude Code project that runs a daily root-cause triage pass over Dylan's Jira support queue.

## What it does

When you run `/daily-triage` inside Claude Code in this folder, the agent:

1. Queries Jira (Atlassian MCP) for every **REC** ticket in status **`REFERRED TO PRODUCT OWNER`** assigned to Dylan.
2. Lists them and asks which to investigate.
3. For each chosen ticket, spawns a `ticket-investigator` subagent that:
   - Reads the ticket and forms ranked hypotheses
   - Pulls Salesforce data via the `sf` CLI (read-only SOQL only)
   - Reads the Salesforce repo via the `github-salesforce` MCP (read-only)
   - Writes structured findings to `investigations/<date>/<KEY>.md`
4. Shows you each finding and asks per-ticket whether to post it as an internal Jira comment via `addCommentToJiraIssue`.
5. Writes a run summary to `investigations/<date>/_summary.md`.

**The agent never writes to Salesforce, never edits code, and never edits Jira tickets — its only side-effect is posting comments you approve.**

## Prerequisites

- Claude Code installed and authenticated.
- `sf` CLI installed at `C:\Program Files\sf\bin\sf.cmd`, authenticated as `dylancr@vatit.com` (run `sf org login web -a dylancr@vatit.com` if not).
- Node.js 18+ at `C:\Program Files\nodejs\node.exe`.
- npm globals installed (these are shared with the po-assistant repo):
  - `npm install -g bitbucket-mcp`
  - `npm install -g @modelcontextprotocol/server-github`
- `.env` populated in this folder — copy `.env.example` and fill in `BITBUCKET_TOKEN` and `GITHUB_TOKEN` (same values as po-assistant's `.env`).
- Atlassian MCP authenticated in Claude Code (it's an OAuth/SSE server — first use will trigger the auth flow).

## Knowledge base

This repo intentionally does not duplicate the company knowledge files. `CLAUDE.md` imports them by absolute path from `C:/My claude code assistants/po-assistant/knowledge/`. Keep those up to date in po-assistant; they flow into the Support Agent automatically.

## How to run

From inside this folder:

```
claude
> /daily-triage
```

That's it. The command walks you through the rest interactively.

## Outputs

```
investigations/
  2026-05-11/
    REC-1234.md          ← per-ticket findings (becomes the Jira comment body)
    REC-1235.md
    _summary.md          ← run rollup
    _observations.md     ← (optional) cross-ticket patterns
    data/                ← raw SOQL exports if any; gitignored
```

## Graduating to a scheduled run

Stay manual until findings are consistently useful (target: >70% of investigations posted as-is without edits). Then promote to either:

- **`/schedule`** (cloud cron) — works only if Salesforce data access stops needing the local `sf` CLI (e.g. via a Salesforce MCP), since cloud runners have no local CLI.
- **Windows Task Scheduler** — local; can keep using the `sf` CLI.

## Architecture

See `CLAUDE.md` for the role definition and hard rules, `.claude/commands/daily-triage.md` for the orchestrator, and `.claude/agents/ticket-investigator.md` for the per-ticket investigator.
