# Playbook: Bug in Salesforce behaviour

## When to use

A REC ticket where the reporter says something in Salesforce did not behave as expected — a flow did not fire, a field was set wrong by automation, an unexpected error appeared, an action that should have happened did not. The reporter is describing **the system did the wrong thing**.

If the ticket is about specific record values being wrong without a clear claim that "the system did the wrong thing" (e.g. "this account is duplicated", "this claim shows $0"), it's a **data anomaly** — use `data-anomaly.md`.

If the reporter is asking for access, it's a **permission request** — use `permission-request.md`.

## Required inputs (from the ticket)

- [ ] What the reporter expected to happen
- [ ] What actually happened
- [ ] At least one specific record / id / URL where the bug was observed
- [ ] When it was observed (date/time, even approximate)

If any of these are missing, the draft is **"needs info from reporter"** — list the specific questions and stop. Do not investigate further.

## Investigation steps

*(Skeleton — flesh out during Phase 2 bootstrap.)*

1. **Confirm the symptom against the actual record.** Pull the record(s) the reporter named via `sf data query`. Does the current state actually match what they described?
2. **Identify the responsible component.** Which trigger / flow / Apex class / validation rule / process builder could have produced this behaviour? Search the Salesforce repo via `github-salesforce` for relevant object names, field names, and error strings from the ticket.
3. **Check what changed recently.** Use git history on the responsible component via the `github-salesforce` MCP. Anything deployed in the time window the reporter mentioned?
4. **Form 2–4 ranked hypotheses.** Each must be specific (names a component) and falsifiable (names the data or code that would refute it).
5. **Gather refuting evidence for each hypothesis** before settling on a likely cause. Refuting evidence is more valuable than confirming evidence.
6. **Calibrate confidence.** *high* = direct evidence supports cause and refutes alternatives. *medium* = supports cause, alternatives plausible. *low* = a reasonable guess, but not nailed down.

## Common root causes

*(Empty — fill during Phase 2 bootstrap. Each entry should be one line: trigger pattern → typical cause → how to spot it.)*

## Comment template

```markdown
## Support Agent — Investigation: <KEY>

**Symptom:** <one sentence>

**Likely cause:** <one sentence>. Confidence: **<high | medium | low>**.

**Evidence:**
- SOQL: <one-line summary of the query and the relevant result — e.g. "Account 001xxx shows Status = 'Closed' but Last_Modified_By is the integration user, not the assigned owner">
- Code: `<repo>/<path>:<line>` — <what it does, and why it relates>
- Recent change (if any): `<commit-sha or PR ref>` — <one-line summary>

**Recommended next step:**
<one of:>
- Needs info from reporter — questions below
- Ready for dev fix — short draft below
- Config / data fix — owner = `<team or person>`
- Cannot reproduce — close as not-a-bug
- Duplicate of `REC-XXXX`

**What I couldn't determine:**
- <gap>
```

## Open questions / unknowns

*(Populate as the agent hits gaps during bootstrap.)*
