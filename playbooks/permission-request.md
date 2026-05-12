# Playbook: Rights / permission request

## When to use

A REC ticket where the reporter is asking for **access they don't have**, or asking why they **lost access**. Examples:

- "I can't see the X tab"
- "I need edit access on the Y object"
- "I've been moved to a new team — please give me Z permissions"
- "I used to be able to do A and now I can't"

If the reporter is describing a system-did-the-wrong-thing scenario (e.g. "my permissions were removed without my knowledge by automation"), that's a **bug** — use `bug.md`.

## Why this is different from the other two

Bugs and data anomalies are **investigations against the system**. Permission requests are **decisions against a policy** — most of which lives in Dylan's head, not in code. The agent's job here is:

1. Establish the user's current effective access.
2. Establish what they're asking for.
3. Surface enough context for Dylan to decide whether to grant.
4. Draft the comment for the ticket once Dylan decides.

The agent does **not** decide whether to grant access. That's always Dylan.

## Required inputs (from the ticket)

- [ ] Who the requester is (user, email, or Salesforce username)
- [ ] What access they want (object, field, tab, report, permission set, profile, role)
- [ ] Their reason for needing it

If the requester or the requested access is unclear, the draft is **"needs info from reporter"** — list the questions and stop.

## Investigation steps

*(Skeleton — flesh out during Phase 2 bootstrap.)*

1. **Identify the requester** in Salesforce via `sf data query` on `User` (by email or username). Capture: profile, role, active permission sets, manager, business unit.
2. **Identify the access being requested.** Map the user's plain-English request to a concrete grant (permission set name, profile change, role move, sharing rule, group membership). If the mapping isn't obvious, ask Dylan.
3. **Compare against peers.** Pull users with the same role/profile/business unit. Do they have the requested access? (Strongest signal for whether this is the standard grant for this role, or an exception.)
4. **Check history.** Has the user previously had this access? (`PermissionSetAssignment` audit fields, `User.History`, or related logs.) If they lost it, when and how?
5. **Surface the policy question.** Hand back to Dylan: "Requester X wants access Y. Peers Z have it. The standard grant for this role is W. Grant / deny?"

## Common root causes / recurring patterns

*(Empty — fill during Phase 2 bootstrap. Likely entries: "moved teams without standard onboarding", "specific permission set required by X workflow", "manager forgot to assign on hire".)*

## Comment template

```markdown
## Support Agent — Investigation: <KEY>

**Request:** <requester> is asking for <one-sentence summary of what they want>.

**Current access (relevant subset):**
- Profile: `<profile>`
- Role: `<role>`
- Permission sets: <list>
- Business unit / team: `<value>`

**What they're asking for (concretely):**
- <permission set / profile change / role / sharing rule>

**Peer comparison:**
- N users in the same `<role / profile / team>` have this access; M do not.
- Standard grant for this role: <yes / no / unclear — ask Dylan>

**History:**
- Previously had this access? <yes — removed on DATE by USER / no / unknown>

**Recommended next step:**
<one of:>
- Grant — standard for the role; ticket can be assigned to `<team>` to execute.
- Grant with caveat — explanation below.
- Deny — explanation below.
- Needs info from reporter — questions below.

**What I couldn't determine:**
- <gap>
```

## Open questions / unknowns

*(Populate as the agent hits gaps during bootstrap. Critical early questions: which permission sets are standard for each role? Who has authority to approve non-standard grants?)*
