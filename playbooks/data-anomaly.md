# Playbook: Data anomaly

## When to use

A REC ticket where the reporter is flagging that **specific records look wrong** — values are unexpected, records are duplicated, records are missing that should exist, fields are blank that should be populated. The reporter is describing the **end state of the data**, not necessarily a system action that produced it.

If the reporter is clearly saying "the system did the wrong thing" (a flow misfired, an error appeared, automation broke), it's a **bug** — use `bug.md`.

If the reporter is asking for access, it's a **permission request** — use `permission-request.md`.

## Required inputs (from the ticket)

- [ ] At least one specific record id / URL showing the anomaly
- [ ] What value / state the record should have, in the reporter's view
- [ ] What value / state it actually has
- [ ] (Optional but helpful) When the record was last expected to be correct

If the first three are missing, the draft is **"needs info from reporter"** — list the specific questions and stop.

## Investigation steps

*(Skeleton — flesh out during Phase 2 bootstrap.)*

1. **Confirm the anomaly.** Pull the record via `sf data query`. Does the data actually look wrong, or is it a misunderstanding of what the field means? (Glossary lookups go here.)
2. **Trace the data lineage.** Where did this record / value originate? User input? Integration? Trigger? Batch job? The investigation depends entirely on which source it is.
3. **Check field history / audit trail.** Use `sf data query` against `<Object>__History` (or the standard `History` related list) to see when the field was last changed and by whom.
4. **Identify the producing component.** Whatever changed the field last → that's the candidate cause. Search the Salesforce repo for that name via `github-salesforce`.
5. **Compare against peers.** Are similar records in the same state correctly? If yes, this is an instance-level issue. If no, it's a pattern.
6. **Form ranked hypotheses with refuting evidence.** Same discipline as the bug playbook.

## Common root causes

*(Empty — fill during Phase 2 bootstrap.)*

## Comment template

```markdown
## Support Agent — Investigation: <KEY>

**Anomaly:** <one sentence — what's wrong with which record(s)>

**Likely cause:** <one sentence>. Confidence: **<high | medium | low>**.

**Lineage:**
- Last modified: <date-time> by `<user or integration name>`
- Producing component: `<repo>/<path>:<line>` (if identified)
- Source of truth (if applicable): <where the correct value lives — e.g. SIMS, a related record>

**Evidence:**
- SOQL on the record: <one-line summary>
- Field history: <one-line summary of relevant entries>
- Peer comparison: <"N similar records are correct" or "M similar records show the same anomaly">

**Recommended next step:**
<one of:>
- Needs info from reporter — questions below
- Data fix needed — owner = `<team or person>`, scope = `<one record / N records / pattern>`
- Ready for dev fix (if the producing component is broken)
- Not an anomaly — expected behaviour (explain)
- Duplicate of `REC-XXXX`

**What I couldn't determine:**
- <gap>
```

## Open questions / unknowns

*(Populate as the agent hits gaps during bootstrap.)*
