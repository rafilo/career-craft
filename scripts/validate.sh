#!/usr/bin/env bash
set -eu

project_dir="$(cd "$(dirname "$0")/.." && pwd)"
status=0

for skill_dir in "$project_dir"/.claude/skills/*; do
  skill_file="$skill_dir/SKILL.md"
  if [ ! -f "$skill_file" ]; then
    echo "Missing SKILL.md: $skill_dir"
    status=1
    continue
  fi
  first_line="$(sed -n '1p' "$skill_file")"
  if [ "$first_line" != "---" ]; then
    echo "Missing frontmatter: $skill_file"
    status=1
  fi
  if ! rg -q '^name: [a-z0-9-]+$' "$skill_file"; then
    echo "Invalid or missing name: $skill_file"
    status=1
  fi
  if ! rg -q '^description: .+' "$skill_file"; then
    echo "Missing description: $skill_file"
    status=1
  fi
done

for required in CLAUDE.md README.md rules/editorial-style.md rules/truthfulness.md rules/ats-and-layout.md; do
  if [ ! -s "$project_dir/$required" ]; then
    echo "Missing required file: $required"
    status=1
  fi
done

if [ "$status" -eq 0 ]; then
  skill_count="$(find "$project_dir/.claude/skills" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
  echo "Validation passed: $skill_count skills found."
fi

exit "$status"

