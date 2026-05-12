# Playbooks

One markdown file per in-scope ticket type. The agent loads the matching playbook at step 3 of the per-ticket loop and follows it as the investigation procedure.

## Files

- `bug.md` — Bugs in Salesforce behaviour
- `data-anomaly.md` — Specific records that look wrong
- `permission-request.md` — Rights / access requests

## Shape

Every playbook has these sections, in this order:

1. **When to use** — the classification rule. Reading just this section should be enough to decide whether a ticket belongs to this playbook.
2. **Required inputs** — what the ticket must contain to investigate. If any are missing, the draft is *"needs info from reporter"* — list the questions and stop.
3. **Investigation steps** — numbered. Each step names the tool and what evidence it captures.
4. **Common root causes** — bullet list. Grows over time. Empty in the initial skeleton.
5. **Comment template** — skeleton for the final Jira comment for this type.
6. **Open questions / unknowns** — gaps the agent has hit. Used as a "look here next" hint.

## How they evolve

Playbooks are **growing documents**, not finished artefacts. During Phase 2 (bootstrap), every real ticket adds to:

- **Common root causes** — when an investigation lands on a cause, write it down.
- **Investigation steps** — when Dylan teaches the agent a missing step, fold it in.
- **Open questions** — when the agent doesn't know what to do, log it so we can answer it.

## When to add a new playbook

If a ticket doesn't fit any of the three existing playbooks but is clearly in scope (Salesforce-only), don't shoehorn it. Stop, mark the ticket out-of-scope for now, and surface it to Dylan. Adding a fourth playbook is a Phase 5 decision and needs an ADR.
