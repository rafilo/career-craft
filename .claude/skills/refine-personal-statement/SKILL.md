---
name: refine-personal-statement
description: Coach a user to improve a CV professional summary or personal statement, explaining the key principles and eliciting evidence before collaboratively refining the text.
argument-hint: "[resume file or pasted statement] [target role/JD optional]"
---

# Refine Personal Statement

Refine: $ARGUMENTS

Read `rules/editorial-style.md`, `rules/truthfulness.md`,
`references/coaching-method.md`, and
`references/personal-statement-framework.md`.

## Workflow

### First response: diagnose and teach

1. Identify the candidate's current professional identity and intended reader.
2. Explain what the statement already communicates and what it fails to establish.
3. Teach no more than three relevant building blocks from the framework.
4. Ask two to five focused questions that would materially improve the statement.
5. Give a short drafting scaffold and invite the user to revise it.
6. Do **not** provide a complete polished replacement on the first response unless
   the user explicitly requests a direct rewrite or text-only answer.

### After the user responds

1. Point out what improved.
2. Explain one or two remaining weaknesses.
3. Refine the user's draft using only confirmed facts.
4. Preserve the candidate's voice, career level, and target.
5. Keep the final version around 70–110 words unless another length is requested.

## Output

For the first response, use:

1. `What is working`
2. `What to improve and why`
3. `Questions for you`
4. `Try this structure`

After the user drafts or explicitly requests direct editing, use:

1. `Refined statement`
2. `Why this version is stronger` — up to three concise bullets
3. `Verify` — only unresolved facts that materially matter
