# ADR 0002: In-scope ticket types are bugs, data anomalies, and permission requests

**Date:** 2026-05-12
**Status:** Accepted

## Context

The REC `REFERRED TO PRODUCT OWNER` queue contains tickets of varied shapes — bugs, data anomalies, process questions, enhancement requests, permission requests, bulk update requests. Each shape needs different investigation patterns. Trying to cover all of them at once would dilute the design and make playbooks unfocused.

## Decision

The agent handles three ticket types in v1:

- **Bug in Salesforce behaviour**
- **Data anomaly**
- **Rights / permission request**

The agent classifies and **refuses** these out-of-scope types:

- Enhancement / change requests
- Bulk update requests
- Process / "why is the system designed this way" questions

Refusal means: the agent says it's out of scope and stops. Dylan handles them manually.

## Alternatives considered

- **All types from day one.** Rejected: process questions and enhancements need Dylan's product judgment, not investigation. Bulk updates need a workflow we don't have. Mixing them dilutes the playbooks.
- **Bugs only.** Rejected: data anomalies are too common to ignore, and permission requests are easy wins where the agent can do real prep work.
- **A single generic playbook.** Rejected: the three types have *materially different* investigation patterns. Bugs and data anomalies are investigations against the system; permission requests are decisions against a policy. Forcing them into one playbook would hide that.

## Consequences

- Three playbooks: `playbooks/bug.md`, `playbooks/data-anomaly.md`, `playbooks/permission-request.md`.
- The classification step in the per-ticket loop must include `out-of-scope` as a valid output.
- Future scope expansion (adding a fourth type) is an ADR change, not a redesign.

## Revisit when

- Phase 4 (steady state) is reached and the three types are running smoothly.
- A pattern of repeat out-of-scope tickets emerges that would benefit from automation.
