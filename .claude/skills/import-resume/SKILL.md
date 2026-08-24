---
name: import-resume
description: Convert a resume PDF into a structured Markdown source file in workspace/resumes/, preserving the candidate's exact wording and flagging anything the extraction could not resolve.
argument-hint: "[resume.pdf] [output path optional]"
---

# Import Resume

Import: $ARGUMENTS

Convert a PDF resume into the project's editable Markdown source format. This is a
conversion task, not a refinement task. Read `rules/truthfulness.md` before writing
the file.

If no file was supplied, ask for the PDF path and stop.

## Reading the PDF

Read the PDF yourself with the Read tool. Do not shell out to `pdftotext`, poppler,
Python, or any other converter, and do not ask the user to install tooling — this
skill must work on a machine with nothing set up.

- Pass the PDF path to Read. It handles both text-layer PDFs and scans or image
  exports, so a resume that was flattened to an image still imports.
- Read covers at most 20 pages per request, and the `pages` parameter is required
  above 10 pages. Resumes are normally one to three pages; for anything longer,
  read in ranges (`"1-10"`, `"11-20"`) and assemble the sections in order.
- Read the whole document before writing anything. Contact details, dates, and role
  boundaries often only resolve once later pages are visible.

Work from what is actually on the page. Reading a rendered page recovers layout —
column order, heading levels, emphasis, what belongs to which role — but it is
transcription, so treat small glyphs, dense tables, and low-resolution scans as the
places most likely to go wrong, and mark them per **Handling uncertainty** below.

## Writing the Markdown

Follow `templates/resume-source.md` for section order and formatting. Map what the
PDF actually contains onto that structure — do not add empty sections to match the
template, and do not drop a section the candidate has just because the template
lacks it.

- Reproduce the candidate's wording verbatim. This step converts format, not prose.
- Keep the original section order unless the PDF's reading order is clearly a
  two-column artefact rather than the author's intent.
- Convert visual bullets, dashes, and glyphs to `-` list items.
- Convert role headings to `### Job Title — Employer` with dates on the line below.
- Preserve dates, employers, titles, and qualifications exactly as written,
  including inconsistent formats. Do not normalise `Jan 2020` and `January 2020`
  into one style here; note it for later instead.
- Drop page numbers, headers, footers, and repeated contact blocks.
- Remove the `references available on request` line, photos, and skill bars.

## Handling uncertainty

Transcription is the weak point of this skill, and a confidently wrong date or
metric is worse than a flagged one. Mark anything you cannot read cleanly with
`[VERIFY: ...]` rather than guessing:

- Characters that are genuinely ambiguous at the rendered size — `1`/`7`, `0`/`O`,
  `5`/`S`, `rn`/`m` — especially inside dates, metrics, and phone numbers.
- Any digit in a number you would otherwise be reporting as fact.
- Ambiguous column order where a bullet may belong to either of two roles.
- Acronyms, product names, and employer names that are stylised, low-contrast, or
  set in a decorative font.
- Text that appears to be missing between pages, or cut off at a margin.
- Anything obscured by a watermark, stamp, redaction, or background graphic.

Never repair a damaged number by inference. A bullet whose percentage will not
resolve becomes `[VERIFY: reduced load times by ?% — digit unclear in source PDF]`,
not a plausible round number.

Be similarly careful with contact details. An email address or phone number
transcribed one character wrong is worse than useless, so flag any character you
are not certain of rather than smoothing it into something that merely looks right.

## Output

Write the file to `workspace/resumes/<name>.md` unless the user gave another path.
Do not overwrite an existing file without confirming first.

Then report:

1. Where the file was written.
2. Sections detected, in order.
3. Every `[VERIFY: ...]` marker, as a short list the user can work through.
4. Anything structural that looked lossy — merged columns, a table that flattened
   badly, a page break mid-bullet.
5. One suggested next step, normally `/audit-resume` on the imported file.

Do not audit, rewrite, reword, or score the resume in this response. Offer that as
the next step and wait.
