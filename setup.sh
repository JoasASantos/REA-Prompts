#!/usr/bin/env bash
# REAP installer — installs the Skills/ prompt packs into your AI coding agent.
#
# Usage:
#   ./setup.sh [agent]     agent: hermes | claude-code | codex | antigravity | all (default: all detected)
#
# What it does:
#   1. Regenerates Skills/ and system_prompt.md from readme.md (if tools/build_skills.py and python3 present)
#   2. Copies every Skills/reap-* folder into the agent's skills directory
set -euo pipefail
cd "$(dirname "$0")"

REGEN=0
if [ -f tools/build_skills.py ] && command -v python3 >/dev/null 2>&1; then
  python3 tools/build_skills.py && python3 tools/build_system_prompt.py && REGEN=1
elif ! command -v python3 >/dev/null 2>&1; then
  echo "note: python3 not found — installing the Skills/ folder as committed"
fi

target_dirs() {
  local agent="${1:-all}"
  case "$agent" in
    hermes)     echo "$HOME/.hermes/skills" ;;
    claude-code|claude) echo "$HOME/.claude/skills" ;;
    codex)      echo "$HOME/.codex/skills" ;;
    antigravity|antigravity-ide|gemini|agy) echo "$HOME/.gemini/config/skills" ;;
    all)
      [ -d "$HOME/.hermes" ] && echo "$HOME/.hermes/skills"
      [ -d "$HOME/.claude" ] && echo "$HOME/.claude/skills"
      [ -d "$HOME/.codex" ]  && echo "$HOME/.codex/skills"
      [ -d "$HOME/.gemini" ] && echo "$HOME/.gemini/config/skills"
      ;;
    *) echo "unknown agent: $agent (use: hermes | claude-code | codex | antigravity | all)" >&2; exit 1 ;;
  esac
}

dirs="$(target_dirs "${1:-all}")"
if [ -z "$dirs" ]; then
  echo "No supported agent directory found (~/.hermes, ~/.claude, ~/.codex, ~/.gemini)."
  echo "Install manually: copy Skills/reap-* into your agent's skills folder."
  exit 1
fi

for d in $dirs; do
  mkdir -p "$d"
  count=0
  for s in Skills/reap-*; do
    rm -rf "$d/$(basename "$s")"
    cp -R "$s" "$d/"
    count=$((count+1))
  done
  echo "installed $count skill pack(s) -> $d"
done

echo
echo "REAP installed. Reload your agent session to pick up the skills."
echo "Full-library system prompt (optional paste): $(pwd)/system_prompt.md"
