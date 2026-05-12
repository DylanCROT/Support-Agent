# ADR 0003: Hybrid build approach — playbook skeletons seeded by bootstrap

**Date:** 2026-05-12
**Status:** Accepted

## Context

The agent needs substantial context: how Salesforce is organised, what the domain objects mean, how Dylan investigates tickets, and what good answers look like. We considered three pure approaches and one hybrid.

The previous (deleted) design tried to import knowledge from a sibling `po-assistant` repo via `@`-imports in `CLAUDE.md`. Dylan explicitly asked to abandon that approach for this agent — knowledge for this agent should live in this repo, scoped to what this agent actually needs.

## Decision

A **hybrid** approach, in this order:

1. **Skeleton playbooks** — one per type — committed up front. Each has the procedural structure but mostly-empty "Common root causes" and "Open questions" sections.
2. **Bootstrap phase** — the agent runs on real tickets with Dylan present. When it doesn't know something, it asks. Each answer is captured into one of:
   - `playbooks/<type>.md` — procedural learnings
   - `glossary/<term>.md` — domain vocabulary (one term per file)
   - `examples/<TICKET-KEY>.md` — worked references from resolved tickets
3. **Examples library** — grows over time from resolved tickets, not authored.

## Alternatives considered

- **Pure static knowledge base authored up front.** Rejected: heavy authoring before we know what's actually needed; risk of writing the wrong things.
- **Pure few-shot from worked examples.** Rejected: brittle on novel tickets; hard to encode the *why* behind decisions.
- **Pure bootstrap (zero authoring; agent asks for everything).** Rejected: Dylan already has system knowledge worth capturing deliberately; the first ~5 tickets would otherwise be very chatty.

## Consequences

- Playbooks are **growing documents**. Phase 2's exit criterion is concrete (≥3 root causes per playbook, ≥2 glossary references each), not "playbook is finished".
- The "ask Dylan + capture answer" loop is a **first-class step** in the per-ticket flow, not an exception path.
- Knowledge capture has three destinations; the agent must classify which one applies. Dylan confirms.
- No shared knowledge import from other agent repos. This agent's knowledge is self-contained.

## Revisit when

- Phase 3 (distil) reveals that the playbook structure isn't holding up — e.g. most learnings keep landing in the glossary, suggesting playbooks are too procedural and not informational enough.
