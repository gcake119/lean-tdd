#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp=$(mktemp -d)
cleanup() {
  rm -rf "$tmp"
}
trap cleanup EXIT HUP INT TERM

CODEX_HOME="$tmp/.codex" "$repo_root/scripts/install.sh"
installed="$tmp/.codex/skills/lean-tdd"

test -f "$installed/SKILL.md"
test -f "$installed/agents/openai.yaml"
cmp "$repo_root/skills/lean-tdd/SKILL.md" "$installed/SKILL.md"
cmp "$repo_root/skills/lean-tdd/agents/openai.yaml" "$installed/agents/openai.yaml"

printf 'Install smoke test passed.\n'
