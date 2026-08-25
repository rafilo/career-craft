#!/usr/bin/env bash
# Behavioural tests: run the coaching commands headlessly against the fixture
# resume and check the responses against the documented pass criteria.
#
# Unlike tests/run-tests.sh these are non-deterministic and cost tokens. They
# answer a question the structural tests cannot: does the command actually coach
# instead of dumping a rewrite? Run them after changing a SKILL.md, a rules file,
# or CLAUDE.md — not on every commit.
#
# Usage:
#   bash tests/run-behaviour.sh              # run scenarios, save transcripts
#   bash tests/run-behaviour.sh --judge      # also grade each one (2x the calls)
#   bash tests/run-behaviour.sh --only audit # run a single scenario
#
# Transcripts land in tests/output/ for reading by eye, which is worth doing even
# when the judge says PASS.
set -u

project_dir="$(cd "$(dirname "$0")/.." && pwd)"
cd "$project_dir"

manifest="tests/scenarios.txt"
guide="tests/fixtures/poor-resume-evaluation-guide.md"
output_dir="tests/output"
judge=0
only=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    --judge) judge=1; shift ;;
    --only) only="${2:-}"; shift 2 ;;
    -h|--help) sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) printf 'Unknown option: %s\n' "$1" >&2; exit 1 ;;
  esac
done

if ! command -v claude >/dev/null 2>&1; then
  printf 'Error: the claude CLI is not on PATH.\n' >&2
  exit 1
fi

[ -f "$manifest" ] || { printf 'Error: %s not found.\n' "$manifest" >&2; exit 1; }
[ -f "$guide" ] || { printf 'Error: %s not found.\n' "$guide" >&2; exit 1; }

mkdir -p "$output_dir"

run_count=0
pass_count=0
fail_count=0
unjudged_count=0

while IFS='|' read -r name tools prompt; do
  # Skip comments and blanks.
  case "$(printf '%s' "$name" | tr -d '[:space:]')" in
    ''|'#'*) continue ;;
  esac

  name="$(printf '%s' "$name" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
  tools="$(printf '%s' "$tools" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
  prompt="$(printf '%s' "$prompt" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

  [ -n "$only" ] && [ "$only" != "$name" ] && continue

  run_count=$((run_count + 1))
  transcript="$output_dir/$name.md"

  printf '\n=== %s ===\n' "$name"
  printf '    %s\n' "$prompt"

  if ! claude -p "$prompt" --allowedTools "$tools" > "$transcript" 2>"$output_dir/$name.err"; then
    fail_count=$((fail_count + 1))
    printf '    ERROR: the command did not complete\n'
    sed -n '1,5p' "$output_dir/$name.err" | sed 's/^/    /'
    continue
  fi

  word_count="$(wc -w < "$transcript" | tr -d ' ')"
  printf '    transcript: %s (%s words)\n' "$transcript" "$word_count"

  if [ "$judge" -eq 0 ]; then
    unjudged_count=$((unjudged_count + 1))
    continue
  fi

  # Grade the transcript against the pass criteria the fixture already defines.
  verdict="$(
    claude -p "You are grading one response from a CV-coaching tool against its own
documented pass criteria. Be strict: this grading exists to catch the tool
regressing into a rewrite-first assistant.

The criteria and the expected findings are in $guide. The response to grade is in
$transcript. Read both files.

Report each criterion from the guide's 'Pass criteria' section as PASS or FAIL with
a one-line reason quoting the response where relevant. Then output a final line that
is exactly 'VERDICT: PASS' or 'VERDICT: FAIL'. FAIL the whole response if it returns
a full rewritten resume without teaching first, invents any metric, or upgrades
support language into leadership." --allowedTools "Read,Glob,Grep" 2>/dev/null
  )"

  printf '%s\n' "$verdict" > "$output_dir/$name.verdict.md"

  if printf '%s' "$verdict" | grep -q 'VERDICT: PASS'; then
    pass_count=$((pass_count + 1))
    printf '    VERDICT: PASS  (%s)\n' "$output_dir/$name.verdict.md"
  else
    fail_count=$((fail_count + 1))
    printf '    VERDICT: FAIL  (%s)\n' "$output_dir/$name.verdict.md"
    printf '%s\n' "$verdict" | grep -E '^\s*-?\s*FAIL' | head -3 | sed 's/^/      /'
  fi
done < "$manifest"

printf '\n%s\n' "----------------------------------------"

if [ "$run_count" -eq 0 ]; then
  printf 'No scenarios ran.'
  [ -n "$only" ] && printf ' No scenario named "%s" in %s.' "$only" "$manifest"
  printf '\n'
  exit 1
fi

if [ "$judge" -eq 0 ]; then
  printf '%s scenarios ran. Transcripts are in %s/ — review them by eye,\n' "$unjudged_count" "$output_dir"
  printf 'or re-run with --judge to grade them against %s.\n' "$guide"
  exit 0
fi

printf '%s passed, %s failed, out of %s scenarios.\n' "$pass_count" "$fail_count" "$run_count"
printf 'A judged FAIL is a prompt to go read the transcript, not proof of a bug.\n'
[ "$fail_count" -eq 0 ] || exit 1
exit 0
