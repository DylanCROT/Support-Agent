# Support Agent

A Claude Code project that investigates Salesforce support tickets on the REC board in status `REFERRED TO PRODUCT OWNER`, assigned to Dylan, and drafts root-cause Jira comments for review.

**Status:** Phase 0 (design). See `PROGRESS.md`.

## What it does (v1)

You invoke it with a Jira URL:

```
/investigate https://vat-it.atlassian.net/browse/REC-1234
```

The agent then:

1. Fetches the ticket via the Atlassian MCP.
2. Classifies it as **bug** / **data anomaly** / **permission request** / **out-of-scope**.
3. Loads the matching playbook from `playbooks/`.
4. Investigates against Salesforce data (read-only `sf data query`) and the Salesforce codebase (read-only `github-salesforce` MCP).
5. Asks you when it hits a gap — captures your answer into a playbook / glossary / example file.
6. Drafts a Jira comment at `investigations/YYYY-MM-DD/<KEY>.md`.
7. Shows the draft and asks **post / edit / discard**.

The agent never writes to Salesforce, never edits code, and never edits Jira state except for posting a single comment after your approval.

**One ticket per invocation.** Batch and scheduled modes are explicitly out of scope.

## Repo map

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Rules and pointers. Minimal — no embedded domain knowledge. |
| `PROGRESS.md` | Build phase tracker. Update each session. |
| `docs/superpowers/specs/` | Design specs. Start with `2026-05-12-support-agent-design.md`. |
| `playbooks/` | One markdown file per in-scope ticket type. Grow over time. |
| `glossary/` | One file per domain term. Grow over time. |
| `examples/` | One file per resolved ticket worth referencing. Grow over time. |
| `investigations/` | Per-run draft comments. `YYYY-MM-DD/<KEY>.md`. |
| `framework-log/` | Audit trail — ADRs, session logs, and a reusable "build phases" guide for future agents. |
| `.claude/settings.json` | Permission deny-list enforcing the read-only rules. |
| `.mcp.json` | MCP server config (Atlassian, github-salesforce, bitbucket). |

## Prerequisites

- Claude Code installed and authenticated.
- `sf` CLI at `C:\Program Files\sf\bin\sf.cmd`, authenticated as `dylancr@vatit.com` (`sf org login web -a dylancr@vatit.com`).
- Node.js 18+ at `C:\Program Files\nodejs\node.exe`.
- `.env` populated — copy `.env.example` and fill in `BITBUCKET_TOKEN` and `GITHUB_TOKEN`.
- Atlassian MCP authenticated in Claude Code (first use will trigger the OAuth flow).

## Building this agent

This project is also a worked example of *how to build an agent like this*. The `framework-log/` folder captures the build process as a reusable framework:

- `framework-log/README.md` — the phases (brainstorm → spec → refactor → plan → bootstrap → distil → steady-state).
- `framework-log/decisions/` — ADRs for each material design choice.
- `framework-log/sessions/` — one file per working session.

If you're starting a new agent project, copy that structure and use the same phases.
