---
name: render-resume
description: Convert a refined Markdown resume into semantic, print-ready A4 HTML/CSS using an ATS-clean, professional-accent, or modern-two-column layout.
argument-hint: "[resume Markdown file] [layout mode] [accent colour optional]"
---

# Render Resume

Render: $ARGUMENTS

Read `rules/ats-and-layout.md`, `references/layout-recipes.md`, and the source resume.
Use the relevant starter in `templates/` as a structural reference.

## Required behaviour

1. Preserve the source content and claims; presentation changes must not create new
   content.
2. Generate a new `.html` file with embedded CSS and semantic headings/lists.
3. Use `@page { size: A4; }`, print-safe margins, predictable page breaks, and no
   remote font dependency.
4. Ensure contact details and dates remain selectable text.
5. Use restrained colour with sufficient contrast; body text stays dark.
6. Avoid essential content in page headers/footers, icons, pseudo-elements, tables,
   or background images.
7. Check for overflow and obvious orphan headings. If browser/PDF rendering is
   available, render and visually inspect before declaring completion.
8. Keep the refined Markdown source as the editable source of truth.

## Deliverables

- Print-ready HTML file
- Short export instruction: open in a browser, print to PDF, A4, scale 100%, browser
  headers/footers off
- Any unresolved overflow or layout warnings

