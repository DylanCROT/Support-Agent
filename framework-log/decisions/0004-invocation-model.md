# ADR 0004: Invocation model — single ticket via Jira URL during bootstrap

**Date:** 2026-05-12
**Status:** Accepted (bootstrap phase only)

## Context

We considered four invocation models: batch (process the full queue), single-ticket (one URL per invocation), interactive batch (queue but pause per ticket), and pick-list (agent shows the queue, Dylan picks).

The previous (deleted) design used a batch model via `/daily-triage` with a subagent per ticket. That was scrapped along with the rest of yesterday's work.

## Decision

During the bootstrap phase, **single ticket via Jira URL**:

```
/investigate https://vat-it.atlassian.net/browse/REC-1234
```

One ticket per invocation. Dylan is present and can answer the agent's questions in real time.

## Alternatives considered

- **Batch mode.** Deferred. Premature while playbooks are still growing — running the agent on 10 tickets unattended would generate 10 unanswered questions and 10 thin investigations. Better to work them together until the playbooks can carry a typical ticket unaided.
- **Pick-list.** Deferred. Useful later as a triage aid but not needed when Dylan is choosing the ticket explicitly by URL.
- **Interactive batch.** Deferred. Same reasoning as batch — only worth it when single-ticket runs need little input.

## Consequences

- The first slash command we build is `/investigate <url>`.
- The command must parse the URL into a ticket key, validate it's a REC ticket, then run the per-ticket loop.
- Batch / queue features are explicitly a **Phase 5** item — out of scope for the current build.

## Revisit when

- Phase 3 (distil) completes — playbooks stable, glossary populated.
- 80%+ of single-ticket runs complete without the agent asking Dylan anything mid-investigation. At that point, batch becomes viable.
