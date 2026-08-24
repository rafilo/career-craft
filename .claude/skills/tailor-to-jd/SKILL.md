---
name: tailor-to-jd
description: Tailor a CV to a specific job description by mapping verified evidence, prioritising relevant content, and using supported ATS terminology without keyword fabrication.
argument-hint: "[resume file/text] [job description file/text]"
---

# Tailor to Job Description

Inputs: $ARGUMENTS

Read `rules/tailoring.md`, `rules/truthfulness.md`,
`references/resume-quality-checklist.md`, and `references/coaching-method.md`.

## Required workflow

1. Read both the complete resume and complete JD.
2. Extract role level, outcomes, essential skills, preferred skills, domain signals,
   and behavioural expectations.
3. Classify every important requirement as strong evidence, partial evidence, not
   evidenced, or not applicable.
4. Explain the two or three most important positioning changes before rewriting.
5. Ask the user for missing evidence where it could turn a partial match into a
   credible strong match.
6. Invite the user to revise one summary sentence or bullet using a supplied
   scaffold before producing the complete tailored version, unless they explicitly
   request a direct rewrite.
7. Rewrite summary, skills ordering, and relevant experience bullets around genuine
   matches after that coaching step.
8. Preserve useful transferable experience and the candidate's identity.
9. Never copy an unsupported JD requirement into the resume.

## Output

First response:

1. `Match summary`
2. `Positioning lessons`
3. `Evidence questions`
4. `Your tailoring exercise`

After user input or an explicit direct-rewrite request:

1. `Tailored resume` — submission-ready Markdown.
2. `What changed and why`
3. `Gaps and verification`

If requested, also provide a requirement-to-evidence table with exact resume
evidence, but keep it separate from the submission document.
