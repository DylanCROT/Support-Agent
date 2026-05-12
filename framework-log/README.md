# Framework Log

This folder is the audit trail for **how the Support Agent was built**. The goal is to make the build process itself reusable — so the next agent (whatever it does) can follow the same phases.

## Structure

- **`decisions/`** — one file per material design decision, in ADR format (Architecture Decision Record). Numbered sequentially. Format: *context → decision → alternatives considered → consequences*.
- **`sessions/`** — one file per working session. File name `YYYY-MM-DD-<topic>.md`. Captures what we discussed, decided, and left open.
- **This README** — the meta-framework: the reusable phase structure for building agents like this.

## The reusable phases

Use these for any agent project that follows the "Claude Code investigates / drafts / hands back to a human" pattern.

### Phase 0 — Brainstorm and spec

Work out what the agent does, what its output is, what's in scope, and how it will get context. Don't write code. Don't scaffold.

Outputs:
- ADRs covering the foundational decisions (output shape, scope, build approach, invocation model).
- A design spec at `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`.
- A session log capturing the brainstorm.

### Phase 1 — Refactor and scaffold

Set up the repo to match the spec. Empty folders for playbooks / glossary / examples. Minimal `CLAUDE.md`. A `PROGRESS.md` tracker. Slash command stubs.

**Do not implement the agent's behaviour yet.** This phase is structural.

### Phase 2 — Write the implementation plan

Use `superpowers:writing-plans` to break the build into reviewable phases. Each phase should have a clear exit criterion.

### Phase 3 — Bootstrap

Run the agent on real cases with the user present. When it hits a gap, capture the answer into the right file (playbook / glossary / example). Update ADRs only when a prior decision is being changed — not for trivia.

Exit criterion: each playbook has enough entries that the agent can run a typical ticket without asking the user mid-investigation.

### Phase 4 — Distil

Review the captured knowledge. Prune what was incidental; promote what was durable. Rewrite playbooks where they've drifted. Start the formal `examples/` library from the highest-value bootstrap runs.

### Phase 5 — Steady state

The agent runs unaided on most cases. Update ADRs only when decisions change.

## How to use this when starting another agent

1. Create the new project folder.
2. Copy this `framework-log/` structure: `README.md` (this file), and empty `decisions/` and `sessions/` folders.
3. Start a `sessions/<date>-brainstorm.md` log on day one.
4. Create ADRs as decisions land. Number them sequentially per project (each project's `decisions/` is its own number space).
5. Don't fill `decisions/` with trivia — only material choices that future-you would want to remember the *why* for.

## Anti-patterns to avoid

- **Implementing before brainstorming.** This project did it on day 1 (yesterday). The previous design was deleted in this refactor. The cost of premature implementation is whatever you've built, plus the cognitive cost of unpicking it.
- **One giant decision doc.** Multiple small ADRs beat one document. Each ADR is independently revisitable.
- **No session logs.** Decisions without context become folklore. The session log is where the *context* lives.
- **Treating the playbooks/glossary/examples as authored.** They are *captured*. The bootstrap phase is what populates them. Authoring them in advance produces speculative content that won't match the real distribution of tickets.
