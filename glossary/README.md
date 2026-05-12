# Glossary

One markdown file per domain term — short, focused. The agent reads matching glossary entries when it encounters unfamiliar terminology during an investigation. It also adds new entries here when Dylan teaches it a new term during a run.

## File shape

Each entry has this structure:

```markdown
# <Term>

**Salesforce object:** `<Object__c>` (if applicable)
**Aliases:** <other names the term goes by — e.g. acronyms, internal jargon>

## What it is
<one paragraph plain-language explanation>

## How it's created
<who/what creates instances of this — user action / automation / integration>

## Related terms
- [[related-term]]
- [[related-term-2]]

## Why it matters for investigations
<one paragraph — what to look for, common confusions, fields that frequently come up>
```

## How to add

When the agent hits an unknown term during an investigation:

1. Agent asks Dylan: "What is X?"
2. Dylan answers.
3. Agent proposes: "I'd like to capture this as `glossary/<slug>.md` — confirm or correct?"
4. On confirm, agent writes the file and continues.

If the term is more procedural than vocabulary ("when investigating bugs, you should also check Y"), it belongs in the relevant playbook, not here.

## When to look here vs in playbooks

- **Glossary** — *what* something is. ("RCT", "claim", "submission packet".)
- **Playbooks** — *how to investigate* a type of ticket. ("When investigating a bug, check recent deploys.")
- **Examples** — *worked references* — concrete resolved tickets.

## Current entries

*(None yet. Populated during Phase 2 bootstrap.)*
