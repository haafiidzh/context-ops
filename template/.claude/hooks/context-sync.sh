#!/usr/bin/env bash
# Stop hook: when a workflow leaves unprocessed handoffs (or a tracked repo moved since the last
# context sync), block the stop once and ask the main thread to run the context-keeper agent.
#
# Tracked repos are listed in .claude/context/repos.conf, one "<name> <path-relative-to-project-root>" per line.
# Without that file the project root itself is tracked as "repo".
# Requires: bash, git, python3 (JSON handling only).
set -u

root="${CLAUDE_PROJECT_DIR:-$(pwd)}"
ctx="$root/.claude/context"
conf="$ctx/repos.conf"
state="$ctx/.sync-state"
lock="$ctx/.sync-lock"
input=$(cat)

# Never re-block a stop that a stop hook already extended (prevents loops).
active=$(printf '%s' "$input" | python3 -c 'import sys,json
try: print(str(json.load(sys.stdin).get("stop_hook_active", False)).lower())
except Exception: print("false")')
[ "$active" = "true" ] && exit 0

# context-keeper holds this lock while it runs; ignore locks older than 30 minutes.
if [ -f "$lock" ] && [ $(( $(date +%s) - $(stat -c %Y "$lock" 2>/dev/null || stat -f %m "$lock") )) -lt 1800 ]; then
  exit 0
fi

reasons=()

# 1. Unprocessed handoffs: any .md directly under handoffs/ except the README.
pending=$(find "$ctx/handoffs" -maxdepth 1 -type f -name '*.md' ! -name README.md 2>/dev/null | sed 's|.*/||' | sort)
if [ -n "$pending" ]; then
  n=$(printf '%s\n' "$pending" | wc -l | tr -d ' ')
  reasons+=("$n unprocessed handoff(s): $(printf '%s' "$pending" | paste -sd, - | sed 's/,/, /g')")
fi

# 2. Repo drift: .sync-state holds "<name> <HEAD sha>" lines written by context-keeper at the end of each pass.
#    Skipped until a first pass has written the file, and for paths that are not git repositories.
if [ -f "$state" ]; then
  if [ -f "$conf" ]; then
    entries=$(grep -vE '^[[:space:]]*(#|$)' "$conf")
  else
    entries="repo ."
  fi
  while read -r name path; do
    [ -z "${name:-}" ] && continue
    head=$(git -C "$root/${path:-.}" rev-parse HEAD 2>/dev/null) || continue
    last=$(awk -v r="$name" '$1==r {print $2}' "$state")
    if [ -n "$last" ] && [ "$head" != "$last" ]; then
      reasons+=("$name has new commits since the last context sync")
    fi
  done <<< "$entries"
fi

[ ${#reasons[@]} -eq 0 ] && exit 0

msg=$(printf '%s; ' "${reasons[@]}")
python3 - "$msg" <<'EOF'
import json, sys
print(json.dumps({
    "decision": "block",
    "reason": "Context sync needed: " + sys.argv[1].rstrip("; ") + ". Before finishing, invoke the "
              "context-keeper agent (Agent tool, subagent_type: context-keeper) for one pass. If developer "
              "or qa agents are still running, or context-keeper is already running, end the turn normally."
}))
EOF
