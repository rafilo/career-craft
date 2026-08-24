---
name: design-resume-layout
description: Design the page layout, sections, typography, spacing, hierarchy, colour, and page-break plan for an A4 CV while protecting ATS readability and content priority.
argument-hint: "[resume file/text] [ATS clean|professional accent|modern two column]"
---

# Design Resume Layout

Design for: $ARGUMENTS

Read `rules/ats-and-layout.md`, `references/layout-recipes.md`, and
`references/section-architecture.md`.

## Workflow

1. Inspect content volume, candidate level, industry, and likely ATS sensitivity.
2. Recommend one layout mode and explain the trade-off in one sentence.
3. Define page count, grid, margins, typography, spacing, colour, section hierarchy,
   date alignment, bullet style, and page-break strategy.
4. Map each resume section to its page region.
5. Flag content that must be shortened before design can work cleanly.
6. Do not use icons, photos, charts, or skill bars for essential information.

## Output

1. `Recommended layout`
2. `A4 design specification` with exact dimensions and type sizes
3. `Section map` by page and region
4. `Low-fidelity wireframe` as nested Markdown headings/lists, not ASCII art
5. `Risks and adjustments`

If the user asks for a usable visual file, continue with `/render-resume` or create
semantic HTML/CSS directly.

