#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skill_dir="$repo_root/skills/lean-tdd"
skill_file="$skill_dir/SKILL.md"

test -f "$skill_file"
test -f "$skill_dir/agents/openai.yaml"
test -f "$repo_root/README.md"
test -f "$repo_root/LICENSE"

if grep -R -nE 'TODO|TBD|FIXME|\[TODO' "$skill_dir"; then
  printf 'Validation failed: placeholder text found.\n' >&2
  exit 1
fi

grep -q '^name: lean-tdd$' "$skill_file"
grep -q '^description: Use when ' "$skill_file"
grep -q 'display_name: "Lean TDD"' "$skill_dir/agents/openai.yaml"
grep -q '\$lean-tdd' "$skill_dir/agents/openai.yaml"

words=$(wc -w < "$skill_file" | tr -d ' ')
if test "$words" -gt 500; then
  printf 'Validation failed: SKILL.md has %s words; budget is 500.\n' "$words" >&2
  exit 1
fi

sh -n "$repo_root/scripts/install.sh"
sh -n "$repo_root/scripts/validate.sh"
sh -n "$repo_root/tests/install-smoke.sh"

validator=${CODEX_SKILL_VALIDATOR:-"${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-creator/scripts/quick_validate.py"}
if test -f "$validator"; then
  if python3 -c 'import yaml' >/dev/null 2>&1; then
    python3 "$validator" "$skill_dir"
  else
    printf 'Official validator found but PyYAML is unavailable; static checks only.\n'
  fi
else
  printf 'Official validator not found; static checks only.\n'
fi

printf 'Validated lean-tdd (%s words).\n' "$words"
