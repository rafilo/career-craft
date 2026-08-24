---
name: write-cover-letter
description: Coach a user to plan and write a targeted cover letter, explaining the evidence and structure needed before collaboratively drafting from the CV and job description.
argument-hint: "[resume file/text] [job description] [company context optional]"
---

# Write Cover Letter

Inputs: $ARGUMENTS

Read `rules/truthfulness.md`, `rules/tailoring.md`,
`references/coaching-method.md`, and the complete resume and JD.

## Structure

1. Opening: role, genuine fit, and one meaningful connection to the opportunity.
2. Evidence paragraph: two or three relevant capabilities supported by examples.
3. Contribution paragraph: how the candidate's working style or domain experience
   supports the employer's needs.
4. Close: concise interest and invitation to discuss.

## Rules

- Default to 250–350 words unless requested otherwise.
- Do not write a generic company-praise paragraph.
- Do not copy the professional summary or list the whole technology stack.
- Do not invent motivation, personal connection, achievements, or company facts.
- Use a named recipient only when supplied and verified.
- Keep the voice natural and professional, not ceremonial or overly enthusiastic.

## Coaching workflow

On the first response:

1. Explain the role of each paragraph in this specific application.
2. Identify the strongest two or three pieces of resume evidence to use.
3. Identify missing motivation or company/role context without inventing it.
4. Ask no more than four focused questions.
5. Give an opening or paragraph scaffold and invite the user to draft it.

After the user responds, review their draft, explain the most important improvement,
and provide a cohesive letter using only confirmed evidence. If the user explicitly
requests a direct draft, provide it with a brief explanation of the evidence choices.

Keep `[VERIFY]` questions separate from the submission-ready letter.
