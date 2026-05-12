# Examples

One markdown file per resolved ticket worth referencing. Used by the agent as worked examples — it pattern-matches the current ticket against these to calibrate depth, tone, and approach.

Examples are **harvested** from resolved tickets, not authored from scratch. Build the library opportunistically during Phase 2 (bootstrap) and Phase 3 (distil).

## File shape

File name: `<TICKET-KEY>.md`.

```markdown
# <TICKET-KEY> — <one-line summary>

**Type:** bug | data-anomaly | permission-request
**Resolved:** <YYYY-MM-DD>
**Outcome:** posted as Jira comment, then <what happened next — fixed by dev / referred to ops / closed>

## The ticket (paraphrased)
<one paragraph paraphrasing what the reporter said. Don't paste names or identifiable info if avoidable.>

## What we investigated
<numbered steps the agent (or Dylan) took, with the tool used at each step>

## What we found
<the actual root cause, in plain language>

## The comment that was posted
<the exact markdown that went into Jira — this is the gold-standard for what good output looks like>

## Why this example is worth keeping
<one paragraph — what's instructive about it. Common pattern? Subtle reasoning? A type of evidence the agent should imitate?>
```

## Selection bar

Not every resolved ticket needs an example. Add one when:

- The investigation pattern is **likely to recur** (same kind of bug, same kind of anomaly).
- The reasoning was **subtle enough that the agent might miss it next time** without a worked reference.
- The **output comment was particularly well-shaped** — good calibration of confidence, good evidence citations, good "next step" framing.

If you're not sure whether to add it, don't. Too many low-quality examples is worse than too few high-quality ones.

## Current entries

*(None yet. Populated during Phase 2 bootstrap and Phase 3 distil.)*
