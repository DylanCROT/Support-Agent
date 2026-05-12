# Session: 2026-05-12 — Initial brainstorm and repo refactor

## What we set out to do

Re-brainstorm the Support Agent from scratch. Dylan flagged that yesterday's session jumped to implementation too fast, producing a working slash-command (`/daily-triage`) and a subagent (`ticket-investigator`) before the design was actually nailed down. Dylan explicitly asked to ignore prior work and prior knowledge imports.

## What we discussed

- The pitfall of building before scoping.
- **Output shape** — what does the agent produce when "done" with one ticket?
- **Ticket-type scope** — which kinds of REC tickets are in scope?
- **Build approach** — how do we give the agent the context it needs without over-authoring?
- **Invocation model** — batch vs single-ticket vs interactive batch vs pick-list.
- **Audit trail** — Dylan wants the build process itself to be a reusable framework for future agents.

Each topic was decided through a single multiple-choice question, one at a time. Full design was then presented in six sections; Dylan approved all of them.

## What we decided

Four ADRs, all in `framework-log/decisions/`:

- **ADR 0001** — Output = draft Jira comment, posted on Dylan's approval.
- **ADR 0002** — In scope: bug / data-anomaly / permission-request. Out of scope: enhancement, bulk update, process question.
- **ADR 0003** — Hybrid build approach: skeleton playbooks + bootstrap capture + examples over time.
- **ADR 0004** — Single ticket via Jira URL during bootstrap (`/investigate <url>`).

## Design sections covered

1. **Per-ticket loop** — fetch → classify → load playbook → investigate → ask-when-stuck → draft → review → post-on-approval.
2. **Playbook structure** — when-to-use / required inputs / steps / common causes / comment template / open questions.
3. **Knowledge capture** — three destinations (playbook / glossary / example); the agent proposes, Dylan confirms.
4. **File layout** — concrete repo tree.
5. **Tool guardrails** — read-only SF data and code; comment-only Jira writes. Existing `settings.json` deny-list is correct.
6. **Audit trail** — this folder.

## What we left open

- The actual content of the playbooks. Skeletons only for now; flesh out during Phase 2 (bootstrap).
- The `/investigate` slash command itself. Implementation plan is the next step (via `superpowers:writing-plans`).
- Whether to mirror the `CLAUDE.md` domain-knowledge imports from `po-assistant`. **Decided no** — this agent's knowledge lives in this repo, scoped to what it actually needs.

## Files created this session

- `docs/superpowers/specs/2026-05-12-support-agent-design.md`
- `CLAUDE.md` (rewritten; previous version preserved in git history)
- `README.md` (rewritten)
- `PROGRESS.md`
- `playbooks/README.md`
- `playbooks/bug.md` (skeleton)
- `playbooks/data-anomaly.md` (skeleton)
- `playbooks/permission-request.md` (skeleton)
- `glossary/README.md`
- `examples/README.md`
- `framework-log/README.md`
- `framework-log/decisions/0001-output-shape.md`
- `framework-log/decisions/0002-ticket-types-in-scope.md`
- `framework-log/decisions/0003-build-approach.md`
- `framework-log/decisions/0004-invocation-model.md`
- This file.

## Files deleted this session

- `.claude/commands/daily-triage.md` (superseded by the per-ticket loop)
- `.claude/agents/ticket-investigator.md` (superseded by the playbook approach — no subagent in the new design)

## Next session

Write the Phase 1 implementation plan via `superpowers:writing-plans`. The first deliverable is `.claude/commands/investigate.md` (the slash command) and a dry-run on a real ticket.
