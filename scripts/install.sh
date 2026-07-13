#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
source_dir="$repo_root/skills/lean-tdd"
codex_home=${CODEX_HOME:-"$HOME/.codex"}
skills_root="$codex_home/skills"
destination="$skills_root/lean-tdd"
timestamp=$(date +%Y%m%d-%H%M%S)

test -f "$source_dir/SKILL.md"
test -f "$source_dir/agents/openai.yaml"
mkdir -p "$skills_root"

stage=$(mktemp -d "$skills_root/.lean-tdd.install.XXXXXX")
cleanup() {
  rm -rf "$stage"
}
trap cleanup EXIT HUP INT TERM

cp -R "$source_dir/." "$stage/"

if test -e "$destination"; then
  backup="$skills_root/lean-tdd.backup-$timestamp"
  mv "$destination" "$backup"
  printf 'Backed up existing skill to: %s\n' "$backup"
fi

mv "$stage" "$destination"
trap - EXIT HUP INT TERM
printf 'Installed lean-tdd to: %s\n' "$destination"
