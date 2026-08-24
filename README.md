# Career Craft for Claude Code

A coaching-first Claude Code project for helping job seekers understand, practise,
and improve CV/resume writing, as well as tailoring applications, auditing content,
redesigning sections, and producing print-ready A4 layouts.

The project does not normally jump straight to a finished rewrite. It diagnoses the
writing, explains the principle, asks focused evidence questions, gives the user a
structure to try, and then reviews and refines the user's draft.

## Quick start

1. Unzip the project and open a terminal in the `resume-refiner` folder.
2. Put source files and job descriptions anywhere inside the project (the suggested
   locations are `workspace/input/` and `workspace/job-descriptions/`).
3. Start Claude Code with `claude`.
4. Type `/` to see the project skills, then invoke one of the commands below.

Claude Code now recommends project skills in `.claude/skills/`. They still appear
and run as slash commands. Existing `.claude/commands/` remains compatible, but
skills can bundle supporting instructions and references.

## Commands

| Command | Purpose |
| --- | --- |
| `/refine-personal-statement` | Teach the building blocks, gather evidence, then collaboratively refine the summary |
| `/coach-experience-writing` | Practise one or two Experience bullets interactively |
| `/refine-experience` | Diagnose Experience bullets, elicit evidence, and refine after user input |
| `/refine-full-resume` | Create a learning plan, practise key fixes, then refine the complete resume |
| `/tailor-to-jd` | Teach the positioning changes before aligning the resume to a JD |
| `/audit-resume` | Diagnose and score the resume, then teach the highest-impact writing lesson |
| `/restructure-resume` | Choose, order, merge, or remove CV sections |
| `/design-resume-layout` | Create an A4 layout specification and text wireframe |
| `/render-resume` | Produce print-ready HTML/CSS using a selected layout system |
| `/write-cover-letter` | Draft a targeted cover letter grounded in resume evidence |
| `/shorten-text` | Reduce content to a requested length while preserving meaning |

Example:

```text
/refine-personal-statement @workspace/input/jane-resume.md
Target role: Senior Frontend Developer
Tone: confident, concise
```

The first response will normally explain what is working, what is unclear, ask a few
questions, and give a drafting scaffold. After the user replies with evidence or a
new attempt, Claude provides feedback and a grounded refined version.

Experience practice:

```text
/coach-experience-writing
Responsible for onboarding new team members.
```

The coach will ask what the user actually created, the scale, who was affected, and
what changed. It will not silently turn the sentence into an invented achievement.

```text
/tailor-to-jd @workspace/input/jane-resume.md @workspace/job-descriptions/frontend.md
```

```text
/design-resume-layout @workspace/output/jane-refined.md
Style: ATS clean
Maximum length: 2 pages
```

```text
/render-resume @workspace/output/jane-refined.md
Layout: professional accent
Accent colour: #D6A84B
```

Arguments may also be pasted directly after the command. When no file or text is
provided, the command asks for the minimum information required.

## Recommended learning workflow

1. `/audit-resume`
2. `/coach-experience-writing` on one or two representative bullets
3. `/refine-personal-statement`
4. `/tailor-to-jd`
5. `/refine-full-resume`
6. `/restructure-resume`
7. `/design-resume-layout`
8. `/render-resume`
9. Proofread the exported PDF before submission

For an urgent application, the user can explicitly request `direct rewrite` or
`text only`. The no-fabrication rules still apply.

## Layout modes

- **ATS Clean** — single column, minimal styling, safest for automated parsing.
- **Professional Accent** — single column with restrained colour and stronger
  hierarchy; suitable for most technology, finance, product, and corporate roles.
- **Modern Two Column** — compact sidebar plus main experience column; best when a
  human-readable version is appropriate. Create a separate ATS version when unsure.

## Output principles

- No fabricated facts or numbers.
- No generic one-size-fits-all profile.
- No keyword stuffing.
- No automatic conversion of `assisted` or `participated` into unsupported
  leadership claims.
- No assumption that every bullet needs a numerical metric.
- No skill bars, rating dots, or charts that ATS tools cannot interpret.
- Content comes before visual decoration.
- Markdown remains the editable source of truth; HTML/CSS is the presentation layer.

## Project map

```text
.claude/skills/       Slash-command workflows
rules/                Shared editorial and design rules
references/           Detailed checklists and layout recipes
templates/            Starter resume and HTML/CSS templates
examples/             Before-and-after examples
scripts/              Project validation
```

Run `bash scripts/validate.sh` after editing the project.
