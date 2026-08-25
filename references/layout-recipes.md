# A4 layout recipes

## 1. ATS Clean

Best for: online applications, conservative organisations, uncertain ATS pipelines.

- Grid: one column
- Margins: 15–17 mm
- Name: 24–28 pt, 700 weight
- Target title: 11–13 pt
- Section headings: 12–14 pt, 700 weight, uppercase optional
- Body: 10–10.5 pt, 1.35 line height
- Colour: charcoal text; one near-black or navy heading colour
- Dates: inline or right-aligned with CSS flex; must wrap safely
- Dividers: thin solid rules only
- Avoid: sidebar, icons, tables, text boxes, background fills

## 2. Professional Accent

Best for: technology, finance, product, operations, professional services.

- Grid: one column with aligned metadata
- Margins: 14–16 mm
- Name: 24–27 pt
- Section headings: 12–13.5 pt with a restrained accent rule
- Body: 9.8–10.5 pt, 1.32–1.4 line height
- Colour: dark grey plus one accent; light tint may be used behind small labels
- Skills: compact grouped rows, never rating bars
- Dates: right-aligned, fall below the title on narrow widths
- Avoid: decorative icon sets and large coloured blocks

A safe warm accent example is `#A87818` for text/rules with a light tint such as
`#F7F0DE`. Verify contrast before using lighter colours for text.

## 3. Modern Two Column

Best for: direct human review where compact scanning matters. Maintain a separate
ATS Clean version if parsing risk is unknown.

- Margins: 12–15 mm
- Sidebar: skills, education, certifications
- Header: name, target role, and contact details, full width above both columns
- Main: summary and professional experience
- Body: at least 9.5 pt
- Never split one experience entry across columns
- Avoid essential facts encoded only through position or colour

### Fixed geometry, not percentages

Every width is a millimetre value. A4 is 210 mm; at 14 mm padding the content box
is 182 mm, split 58 mm sidebar + 8 mm gap + 116 mm main column.

Percentages resolve against the viewport on screen and against the page box in
print, so a percentage-width sidebar renders at one size in the browser and another
in the PDF. The candidate proofreads on screen and sends the PDF, so the two must be
identical.

### One explicit page box per page

Wrap each page in a `.page` element with `width: 210mm; height: 297mm; padding:
14mm`, set `@page { size: A4; margin: 0 }`, and put the break on the element
(`break-after: page`).

Confine the two-column split to page one. Grid and float layouts both fail at the
page boundary — a grid row spans both tracks, so the sidebar follows the main column
onto page two and paints an empty tinted block down the whole page. Inside a fixed
page box the split never crosses a break, so neither failure can happen. Later pages
are single column at the full 182 mm.

Make page one a flex column: header at natural height, then the split with
`flex: 1 1 auto`. The sidebar then stretches to the foot of the page by itself.
Never hand-tune a `min-height` for this — it is a magic number that silently breaks
when the header grows by a line.

### The cost: verify the page fill

Fixed page boxes do not reflow. Content exceeding 297 mm spills into the bottom
margin and then past the page edge, and it does so **silently**: the page count does
not change and a thumbnail looks fine.

After any content edit, render to PDF and confirm the ink in each column stops
before the bottom margin — 283 mm from the page top at 14 mm margins. Move material
between `.page` elements by hand until it does. Real candidate content will not fall
where the template's placeholder content did.

## Page-break rules

- `break-inside: avoid` for role headings and short entries.
- Do not force a long role to remain unbroken if it creates excessive blank space.
- `break-after: avoid` for section headings, and on the date/location line so a
  heading is never separated from the entry it introduces.
- `break-before: avoid` on the bullet list for the same reason.
- Keep at least two bullets together where practical: `orphans: 2; widows: 2` on
  paragraphs and list items. Nothing else implements this rule.
- Repeat no decorative banner on later pages.

## Printing colour

Any layout using a tint or fill must set `print-color-adjust: exact` (with the
`-webkit-` prefix) on `html`. Chrome's Print → Save as PDF dialog has "Background
graphics" switched **off** by default, so without this the fill silently prints
blank and the layout loses the element it was built around. Headless Chrome forces
backgrounds on, so this defect does not appear in an automated render — only for
the user following the documented export steps.

Prefer borders and rules over fills where the design allows: a border always prints.

## Content-density thresholds

- If body text must fall below 9.5 pt, edit content or accept an additional page.
- If more than seven skill groups are needed, combine or prioritise them.
- If the summary exceeds roughly one-sixth of page one, shorten it.
- If every role has equal detail, reweight by relevance and recency.

