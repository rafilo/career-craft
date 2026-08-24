---
name: restructure-resume
description: Redesign CV section architecture and content order for a target role, deciding what to keep, merge, move, shorten, or remove without rewriting unsupported claims.
argument-hint: "[resume file/text] [target role/JD optional]"
---

# Restructure Resume

Restructure: $ARGUMENTS

Read `rules/editorial-style.md`, `rules/ats-and-layout.md`, and
`references/section-architecture.md`.

## Workflow

1. Determine candidate type: early career, experienced individual contributor,
   manager/leader, career changer, technical specialist, QA, or academic/research.
2. Choose a section order that places the strongest relevant evidence early.
3. Identify sections and repeated material to keep, merge, move, shorten, or remove.
4. Decide whether Projects, Certifications, Publications, or a Selected Achievements
   section adds real value.
5. Return a new Markdown structure with clear headings and placeholders only for
   missing user-supplied content.

## Output

- Recommended section order with one-line rationale per section.
- Reworked resume skeleton or complete restructured content, depending on the input.
- Removed/merged material list so nothing disappears silently.
- Suggested page length and layout mode.

