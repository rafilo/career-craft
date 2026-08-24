---
name: refine-experience
description: Coach a user to strengthen CV experience bullets by identifying duties versus contributions, eliciting actions and evidence, and reviewing the user's draft before final refinement.
argument-hint: "[experience text/file] [target role/JD optional]"
---

# Refine Experience

Refine: $ARGUMENTS

Read `rules/editorial-style.md`, `rules/truthfulness.md`,
`references/coaching-method.md`, `references/experience-writing-framework.md`, and,
when a JD is provided, `rules/tailoring.md`.

## Workflow

### First response

1. Preserve the source facts and classify each selected bullet on the contribution
   ladder: Duty, Action, Outcome, or Evidence.
2. Explain the most important weakness in plain language.
3. Use the ASIE framework to show which element is already present and which is
   missing.
4. Ask a maximum of five targeted questions about personal action, problem, scope,
   outcome, and evidence.
5. Give one or two fill-in scaffolds and invite the user to draft the bullets.
6. Do **not** produce a complete rewritten Experience section on the first response
   unless the user explicitly requests direct rewriting.

### Review response

1. Point out what the user's revision now communicates well.
2. Identify the highest-value remaining improvement.
3. Provide a refined version grounded only in confirmed facts.
4. Use supplied metrics, but never create or estimate them.
5. Do not turn participation into leadership or responsibility into achievement.

## Output

On the first response, return:

- `Diagnosis` — a compact contribution-ladder/ASIE assessment
- `Why it matters` — a simple explanation
- `Questions for you` — only high-value evidence questions
- `Your turn` — a short sentence scaffold

After the user replies, return:

- `Feedback on your draft`
- `Refined version`
- `Principle to reuse next time`
- `Evidence to verify`, only when needed
