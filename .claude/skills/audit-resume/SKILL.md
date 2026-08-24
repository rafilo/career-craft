---
name: audit-resume
description: Audit a CV for positioning, evidence, relevance, ATS compatibility, structure, consistency, and readability, with prioritised fixes rather than a generic checklist.
argument-hint: "[resume file/text] [job description optional]"
---

# Audit Resume

Audit: $ARGUMENTS

Read `references/resume-quality-checklist.md`, `references/coaching-method.md`,
`references/experience-writing-framework.md`,
`references/personal-statement-framework.md`, and all files in `rules/`. Do not
rewrite the full resume unless the user asks.

## Scorecard

Score each dimension from 1–5 and cite concrete evidence:

- Target-role clarity
- Professional summary
- Experience evidence
- Relevance and prioritisation
- Skills architecture
- ATS safety
- Readability and visual hierarchy
- Consistency and polish
- Truthfulness risk

## Output

1. Overall diagnosis in two to four sentences.
2. Compact score table.
3. `Fix first` — no more than five high-impact issues, in priority order.
4. `Quick wins` — low-effort improvements.
5. `Verify` — possible unsupported, ambiguous, or inconsistent claims.
6. `Learning focus` — teach the one writing principle that would improve the
   greatest number of sections.
7. `Experience sample` — assess up to three representative bullets using the rubric
   in `references/experience-writing-framework.md`, not every bullet mechanically.
8. `Try it yourself` — select one weak sentence, ask focused evidence questions,
   and provide a scaffold for the user to revise it.

Distinguish content problems from layout problems. Do not penalise a two-page resume
merely for not being one page.

Do not attach a fully rewritten CV to the first audit response. The audit should
help the user understand and prioritise changes. Offer collaborative refinement as
the next step.
