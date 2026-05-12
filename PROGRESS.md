# Support Agent — Build Progress

Where we are in building the Support Agent. Update each working session.

## Current phase

**Phase 0 — Design.** Spec written; awaiting Dylan's review and approval to move into implementation planning.

## Phases

### Phase 0 — Design
- [x] Brainstorm output shape, scope, build approach, invocation model (2026-05-12)
- [x] Draft full design spec → `docs/superpowers/specs/2026-05-12-support-agent-design.md`
- [x] Refactor repo to match design (folders, skeletons, ADRs, session log)
- [ ] Dylan reviews spec and confirms
- [ ] Write implementation plan (via `superpowers:writing-plans`)

### Phase 1 — Scaffolding
- [ ] `.claude/commands/investigate.md` — the `/investigate <jira-url>` slash command
- [ ] URL → ticket-key parsing logic
- [ ] Classification step (with confirmation gate)
- [ ] Playbook-loading step
- [ ] Draft → review → post flow with Atlassian MCP
- [ ] First end-to-end dry-run on a real ticket

### Phase 2 — Bootstrap (~10 tickets)
- [ ] Run agent on real tickets with Dylan present
- [ ] Capture knowledge into `playbooks/` / `glossary/` / `examples/` after each
- [ ] Update ADRs when prior decisions need revisiting
- [ ] Exit criterion: each playbook has ≥3 entries in "Common root causes" and ≥2 referenced glossary terms

### Phase 3 — Distil
- [ ] Review playbook drift across bootstrap tickets
- [ ] Prune incidental knowledge; promote durable patterns
- [ ] Start formal `examples/` library from highest-value bootstrap runs
- [ ] Exit criterion: playbook diffs stabilise; `examples/` has ≥5 entries

### Phase 4 — Steady state
- [ ] Agent runs unaided on 80%+ of tickets without asking Dylan mid-investigation
- [ ] Document the steady-state operating model in `framework-log/sessions/`

### Phase 5 — Later (out of scope for now)
- Batch / queue mode
- Scheduled runs (Windows Task Scheduler or cloud cron)
- Adding enhancement / bulk-update / process-question ticket types
