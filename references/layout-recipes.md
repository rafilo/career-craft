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

- Grid: 31–34% sidebar, remaining width main content
- Margins: 12–15 mm
- Sidebar: contact, skills, education, certifications
- Main: summary and professional experience
- Body: at least 9.5 pt
- Gap: 7–10 mm
- Reading order in HTML: header, summary, experience, then supporting sections where
  possible; CSS Grid controls visual placement
- Never split one experience entry across columns
- Avoid essential facts encoded only through position or colour

## Page-break rules

- `break-inside: avoid` for role headings and short entries.
- Do not force a long role to remain unbroken if it creates excessive blank space.
- `break-after: avoid` for section headings.
- Keep at least two bullets together where practical.
- Repeat no decorative banner on later pages.

## Content-density thresholds

- If body text must fall below 9.5 pt, edit content or accept an additional page.
- If more than seven skill groups are needed, combine or prioritise them.
- If the summary exceeds roughly one-sixth of page one, shorten it.
- If every role has equal detail, reweight by relevance and recency.

