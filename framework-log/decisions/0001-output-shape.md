# ADR 0001: Agent output is a draft Jira comment

**Date:** 2026-05-12
**Status:** Accepted

## Context

We needed to decide what the Support Agent produces at the end of investigating one ticket. The space of options ranged from "just gathers raw evidence and hands it to Dylan" to "drives the full workflow including transitions and reassignments".

## Decision

The agent produces a **draft Jira comment** in markdown, written to `investigations/YYYY-MM-DD/<KEY>.md`. Dylan reviews it, optionally edits, and approves "post" — at which point the agent posts via `addCommentToJiraIssue`. The agent never transitions tickets, edits fields, reassigns, or creates issues.

## Alternatives considered

- **Full workflow under approval** (investigate → comment → transition → reassign, each gated). Rejected: adds Jira mutation surface area we don't need yet. Premature.
- **Triage note for Dylan only** (private to Dylan, no Jira write at all). Rejected: loses the leverage of producing posted material directly. Dylan would still have to write the Jira comment by hand.
- **Evidence pack only** (raw SOQL, file paths, links — no synthesis). Rejected: forces Dylan to do the writing. The agent isn't paying for itself.

## Consequences

- The only Jira write the agent can make is `addCommentToJiraIssue`, gated per-ticket by Dylan's approval.
- `.claude/settings.json` deny-list reflects this (already in place — other Atlassian mutations are denied).
- The shape of the draft markdown is constrained by what reads well as a Jira comment — plain language, evidence cited inline, confidence calibration.
- Each playbook has its own `Comment template` section, because the right structure differs across bug / data-anomaly / permission-request.

## Revisit when

- The agent is stable enough that escalating to transitions and reassignments would save real time (Phase 4+).
