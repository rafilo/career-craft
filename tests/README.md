# Testing CareerCraft

The commands in this project are prompts, not code. That changes what "testing"
means: there is no function to assert on, and the same command run twice will not
produce identical text. So the tests split into two tiers that answer different
questions.

| Tier | Question | Deterministic | Cost | When to run |
| --- | --- | --- | --- | --- |
| Structural | Are the skill files well-formed and consistent with each other? | Yes | Free | Every change |
| Behavioural | Does the command actually coach instead of rewriting? | No | Tokens + ~1 min per scenario | After editing a skill, rule, or CLAUDE.md |

## Tier 1 — structural

```bash
bash tests/run-tests.sh
```

Runs in under a second, needs nothing installed, and exits non-zero on failure.
It wraps `scripts/validate.sh` and adds the checks that catch real drift:

- **Frontmatter** — `name` matches the directory, the block is closed, an
  `argument-hint` is declared, and the body has a heading and uses `$ARGUMENTS`.
  A skill whose frontmatter is unclosed silently stops working.
- **Cross-references** — every `references/`, `rules/`, `templates/`, `scripts/`,
  or `examples/` path mentioned in any SKILL.md, `CLAUDE.md`, or the README must
  exist. A skill that tells Claude to read a deleted file degrades quietly.
- **README sync** — every skill has a row in the commands table and every
  documented command has a skill. This catches both directions of drift.
- **Workspace layout** — the `.gitkeep` files survive, and candidate material in
  `workspace/resumes/` and `workspace/output/` is genuinely git-ignored. Verified
  with `git check-ignore`, not by reading `.gitignore`.
- **Fixtures** — the fixture files exist, and every command and path the
  evaluation guide suggests still resolves.

These checks have been verified to fail on: a deleted rules file, a skill added
without a README row, a renamed skill directory, unclosed frontmatter, and a
`.gitignore` that stops protecting candidate data.

## Tier 2 — behavioural

```bash
bash tests/run-behaviour.sh                # run scenarios, save transcripts
bash tests/run-behaviour.sh --judge        # also grade them (2x the calls)
bash tests/run-behaviour.sh --only audit   # one scenario
```

Runs each scenario in `tests/scenarios.txt` through `claude -p` against
`fixtures/poor-resume.md`, saving transcripts to `tests/output/` (git-ignored).

`--judge` then grades each transcript against the `Pass criteria` section of
`fixtures/poor-resume-evaluation-guide.md` and prints `VERDICT: PASS` or
`VERDICT: FAIL`. The judge is instructed to fail outright on the three regressions
that matter most: returning a full rewrite without teaching, inventing a metric, or
upgrading support language into leadership.

**A judged FAIL is a prompt to read the transcript, not proof of a bug.** The judge
is a model, so it is occasionally wrong in both directions. The transcripts are the
real artefact — reading one is worth more than the verdict, including when it says
PASS.

### Adding a scenario

Append a line to `tests/scenarios.txt`:

```text
name | allowed-tools | prompt
```

Keep the prompt on one line. `allowed-tools` is passed to `claude --allowedTools`;
`Read,Glob,Grep` is right for the coaching commands. Commands that write files
(`/import-resume`, `/render-resume`) need `Write` as well, and are better tested by
hand — their output is a file to inspect, not a response to grade.

## What is not covered

- **`/import-resume`** — needs a PDF fixture and produces a file rather than a
  response. Test by hand against a real resume and check the `[VERIFY: ...]`
  markers, which is the part most likely to regress.
- **`/render-resume`** — produces HTML whose real test is printing it to A4 and
  looking at the page breaks. `rules/ats-and-layout.md` is the checklist.
- **Whether the coaching actually teaches anyone anything.** No harness measures
  that. It needs a person working through a real CV.
