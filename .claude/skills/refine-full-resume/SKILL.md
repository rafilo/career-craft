---
name: refine-full-resume
description: Refine an entire CV section by section for clarity, credibility, consistency, relevance, and ATS readability while retaining every factual constraint.
argument-hint: "[resume file] [target role/JD optional]"
---

# Refine Full Resume

Resume and context: $ARGUMENTS

Read all files in `rules/`. Read `references/resume-quality-checklist.md` and
`references/coaching-method.md`.

## Workflow

### Phase 1: learning plan

1. Inspect the complete resume before editing any one section.
2. Establish the target, career level, evidence, transferable skills, and major gaps.
3. Identify the three highest-impact patterns across the document.
4. Explain each pattern with one short example and a practical rule.
5. Choose one representative summary sentence and one experience bullet for guided
   practice. Ask focused questions and invite the user to revise them.
6. Do not rewrite the full resume in this first phase unless the user explicitly
   requests direct rewriting.

### Phase 2: collaborative refinement

1. Review the user's attempts and explain what improved.
2. Apply the confirmed principles throughout the document.
3. Correct structure, section names, terminology, grammar, tense, dates, and
   repetition.
4. Remove content only when redundant, irrelevant, unsafe, or low-value; report
   material removals.
5. Keep all claims grounded. Place uncertainties in a separate `[VERIFY]` list.
6. Save a new Markdown file when working from a file; do not overwrite the only
   source copy.

## Output order

For Phase 1:

1. Resume diagnosis
2. Three learning priorities
3. Guided practice
4. Information to verify

For Phase 2:

1. Refined resume
2. What the user's revisions improved
3. Material changes made
4. Information to verify or add
