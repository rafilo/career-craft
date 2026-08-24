# Poor resume evaluation guide

Use this only to evaluate CareerCraft's behaviour. Do not provide it as input when
testing the resume commands.

The candidate and employers are fictional. The resume intentionally combines weak
writing with several useful facts that a coaching workflow should help uncover.

## What the fixture should test

### Coaching behaviour

- The first response explains the most important problems before rewriting.
- It asks focused questions and invites the user to revise representative content.
- It does not immediately return a fully rewritten resume unless explicitly asked.
- It does not overwhelm the user with every possible issue at once.

### Personal statement

Expected findings:

- Generic objective language and unsupported adjectives
- Opens with years and enthusiasm rather than professional value
- Unfocused target: Full Stack Developer / Software Engineer / IT Professional
- Dense technology claims that duplicate Skills
- Unsupported promises such as `always give 110%` and `great asset`
- No credible differentiator, delivery scope, or domain context

Good coaching should ask about the target role, strongest capabilities, ownership,
delivery context, and what the candidate wants a recruiter to remember.

### Experience

Expected findings:

- Repeated `Responsible for`, `Worked on`, `Helped`, `Assisted`, and `Participated`
- Duties are mixed with genuine evidence but the candidate's action is often unclear
- The `60%` API claim lacks a baseline, metric definition, and explanation
- The portal bullet contains useful scope and completion evidence but buries it
- The support-rotation bullet contains frequency but not contribution or outcome
- The mentoring bullet provides four new developers but does not establish what the
  candidate actually did for them
- The Playwright bullet contains strong action, scale, and before/after evidence but
  leads with `Worked on`
- The AWS and booking-platform bullets require ownership questions
- Current/past tense and date formats are inconsistent

The coach must not automatically turn participation into leadership. It should ask
what the candidate personally designed, built, tested, coordinated, or delivered.

### Skills and evidence

Expected findings:

- Skill-rating stars are subjective and ATS-unfriendly
- The skill list is too broad and ungrouped
- Several technologies have little or no experience evidence
- `AI` and `LLM` are vague; the resume should explain actual workflow usage
- Soft skills are claimed in both Skills and Personal Attributes without evidence

### Structure and ATS

Expected findings:

- Multiple target titles weaken positioning
- Full street address is unnecessary
- All-caps headings are not fatal but hierarchy needs consistency
- Key Achievements repeats vague claims and separates them from evidence
- Projects duplicate Experience without adding detail
- Personal Attributes, Interests, and References are low priority for the target
- Education institution naming may need verification
- Certification names, issuers, and dates are incomplete
- Likely two pages unless redundant material is removed

## Facts CareerCraft may safely use

These facts appear in the fixture and may be preserved or reorganised:

- The portal serves approximately 25,000 customers monthly.
- The portal migration finished in November 2024.
- Production support rotation occurs one week in six.
- Four developers joined during 2024.
- The candidate created 120 Playwright tests.
- Regression testing fell from about two days to four hours.

CareerCraft must not assume:

- The candidate led either migration.
- The candidate personally onboarded all four developers.
- What `60% faster` measured or how it was achieved.
- That the booking platform was successful.
- That AWS, Kubernetes, Terraform, AI, or LLM capability is advanced.
- Any revenue, budget, team size, customer-satisfaction change, or cost saving.

## Suggested test commands

```text
/audit-resume @tests/fixtures/poor-resume.md
```

```text
/refine-personal-statement @tests/fixtures/poor-resume.md
Target role: Senior Full Stack Developer
```

```text
/coach-experience-writing @tests/fixtures/poor-resume.md
Focus on the KiwiCloud Solutions role.
```

```text
/refine-experience @tests/fixtures/poor-resume.md
Focus on the BrightLane Systems role.
```

```text
/restructure-resume @tests/fixtures/poor-resume.md
Target role: Senior Full Stack Developer
```

## Pass criteria

The output passes when it:

- teaches before rewriting by default;
- identifies real evidence already present;
- asks for missing action/ownership rather than guessing;
- challenges vague or unsupported metrics;
- does not demand a number for every bullet;
- does not upgrade support language into leadership;
- prioritises a small number of high-impact learning points;
- preserves the fictional candidate's own positioning and facts.

