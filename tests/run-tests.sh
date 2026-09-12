#!/usr/bin/env bash
# Deterministic checks for the CareerCraft project.
#
# These test the things that can actually be wrong in a prompt-based project:
# malformed skill files, references to files that no longer exist, and drift
# between the README and the skills on disk. They do not test what Claude says
# when a command runs — see tests/run-behaviour.sh for that.
#
# Usage: bash tests/run-tests.sh
set -u

project_dir="$(cd "$(dirname "$0")/.." && pwd)"
cd "$project_dir"

pass_count=0
fail_count=0
current_group=""

group() {
  current_group="$1"
  printf '\n%s\n' "$current_group"
}

pass() {
  pass_count=$((pass_count + 1))
  printf '  ok   %s\n' "$1"
}

fail() {
  fail_count=$((fail_count + 1))
  printf '  FAIL %s\n' "$1"
  if [ "$#" -ge 2 ]; then
    printf '       %s\n' "$2"
  fi
}

skill_dirs() {
  find .claude/skills -mindepth 1 -maxdepth 1 -type d | sort
}

# Strip YAML frontmatter so body-only checks do not match the description field.
skill_body() {
  awk 'NR > 1 && /^---$/ { found = 1; next } found' "$1"
}

# ---------------------------------------------------------------------------
group "Project validation (scripts/validate.sh)"
# ---------------------------------------------------------------------------

if validate_output="$(bash scripts/validate.sh 2>&1)"; then
  pass "validate.sh passes"
else
  fail "validate.sh reports problems" "$validate_output"
fi

# ---------------------------------------------------------------------------
group "Skill frontmatter"
# ---------------------------------------------------------------------------

for dir in $(skill_dirs); do
  skill_name="$(basename "$dir")"
  file="$dir/SKILL.md"

  [ -f "$file" ] || continue

  declared_name="$(grep -m1 '^name:' "$file" | sed 's/^name:[[:space:]]*//')"
  if [ "$declared_name" = "$skill_name" ]; then
    pass "$skill_name: name matches directory"
  else
    fail "$skill_name: name does not match directory" "frontmatter says '$declared_name'"
  fi

  # The closing --- must exist or the whole file is read as frontmatter.
  if [ "$(grep -c '^---$' "$file")" -ge 2 ]; then
    pass "$skill_name: frontmatter is closed"
  else
    fail "$skill_name: frontmatter is not closed" "expected a second '---' line"
  fi

  if grep -q '^argument-hint:' "$file"; then
    pass "$skill_name: declares argument-hint"
  else
    fail "$skill_name: missing argument-hint" "users see this as the slash-command placeholder"
  fi

  if skill_body "$file" | grep -q '^# '; then
    pass "$skill_name: body has a heading"
  else
    fail "$skill_name: body has no H1 heading"
  fi

  if skill_body "$file" | grep -q '\$ARGUMENTS'; then
    pass "$skill_name: body uses \$ARGUMENTS"
  else
    fail "$skill_name: body never uses \$ARGUMENTS" "the command cannot receive input"
  fi
done

# ---------------------------------------------------------------------------
group "Cross-references resolve"
# ---------------------------------------------------------------------------

# Any project-relative path mentioned in a skill, CLAUDE.md, or the README must
# exist. This is what catches a deleted script or a renamed reference file.
referenced_paths="$(
  grep -ohE '(references|rules|templates|scripts|examples)/[A-Za-z0-9._-]+\.(md|sh|html)' \
    .claude/skills/*/SKILL.md CLAUDE.md README.md 2>/dev/null | sort -u
)"

if [ -z "$referenced_paths" ]; then
  fail "no cross-references found" "the grep pattern is probably wrong"
else
  for path in $referenced_paths; do
    if [ -e "$path" ]; then
      pass "$path exists"
    else
      fail "$path is referenced but missing" "$(grep -lE "$path" .claude/skills/*/SKILL.md CLAUDE.md README.md 2>/dev/null | tr '\n' ' ')"
    fi
  done
fi

# ---------------------------------------------------------------------------
group "README matches skills on disk"
# ---------------------------------------------------------------------------

readme_commands="$(grep -oE '^\| `/[a-z-]+`' README.md | tr -d '|` /' | sort -u)"

for dir in $(skill_dirs); do
  skill_name="$(basename "$dir")"
  if printf '%s\n' "$readme_commands" | grep -qx "$skill_name"; then
    pass "/$skill_name is documented in the README table"
  else
    fail "/$skill_name is missing from the README commands table"
  fi
done

for command_name in $readme_commands; do
  if [ -d ".claude/skills/$command_name" ]; then
    pass "/$command_name in the README has a skill"
  else
    fail "/$command_name is documented but no skill exists" "stale README row"
  fi
done

# ---------------------------------------------------------------------------
group "Workspace layout"
# ---------------------------------------------------------------------------

for workspace_dir in workspace/input workspace/output workspace/job-descriptions workspace/resumes; do
  if [ -f "$workspace_dir/.gitkeep" ]; then
    pass "$workspace_dir/ is kept in git"
  else
    fail "$workspace_dir/.gitkeep is missing" "the folder will vanish on clone"
  fi
done

# Candidate material must never be committed by accident.
for ignored in workspace/resumes/candidate.md workspace/resumes/candidate.pdf workspace/output/resume.pdf; do
  if git check-ignore -q "$ignored" 2>/dev/null; then
    pass "$ignored is git-ignored"
  else
    fail "$ignored is NOT git-ignored" "candidate data could be committed"
  fi
done

# ---------------------------------------------------------------------------
group "Test fixtures"
# ---------------------------------------------------------------------------

for fixture in tests/fixtures/poor-resume.md tests/fixtures/poor-resume-evaluation-guide.md; do
  if [ -s "$fixture" ]; then
    pass "$(basename "$fixture") exists and is not empty"
  else
    fail "$fixture is missing or empty"
  fi
done

# The evaluation guide suggests commands; each must still exist.
guide_commands="$(grep -oE '^/[a-z-]+' tests/fixtures/poor-resume-evaluation-guide.md | tr -d '/' | sort -u)"
for command_name in $guide_commands; do
  if [ -d ".claude/skills/$command_name" ]; then
    pass "evaluation guide references /$command_name"
  else
    fail "evaluation guide references /$command_name, which no longer exists"
  fi
done

guide_fixtures="$(grep -oE '@tests/fixtures/[A-Za-z0-9._-]+' tests/fixtures/poor-resume-evaluation-guide.md | tr -d '@' | sort -u)"
for path in $guide_fixtures; do
  if [ -e "$path" ]; then
    pass "evaluation guide fixture path $path resolves"
  else
    fail "evaluation guide points at missing fixture $path"
  fi
done

# ---------------------------------------------------------------------------
printf '\n%s\n' "----------------------------------------"
if [ "$fail_count" -eq 0 ]; then
  printf 'All %s checks passed.\n' "$pass_count"
  exit 0
fi

printf '%s passed, %s failed.\n' "$pass_count" "$fail_count"
exit 1
