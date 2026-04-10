#!/usr/bin/env bash
set -uo pipefail

MODE="${1:---hook}"
PROFILE="$HOME/.devloop/profile.md"
HISTORY="$HOME/.devloop/history.jsonl"

# Not onboarded — available (context) or silent (hook)
if [ ! -f "$PROFILE" ]; then
  [ "$MODE" = "--context" ] && echo "GROW_AVAILABLE=true"
  exit 0
fi

# Parse lastRun from YAML frontmatter
LAST_RUN=$(sed -n '/^---$/,/^---$/p' "$PROFILE" | grep '^lastRun:' | head -1 | sed 's/lastRun:[[:space:]]*//' | tr -d "\"'")
if [ -z "$LAST_RUN" ]; then
  [ "$MODE" = "--context" ] && echo "GROW_AVAILABLE=true"
  exit 0
fi

LAST_DATE="${LAST_RUN%%T*}"
TODAY=$(date +%Y-%m-%d)

# Check 1: 2-calendar-day gap
NEXT=$(date -j -v+2d -f "%Y-%m-%d" "$LAST_DATE" +%Y-%m-%d 2>/dev/null \
    || date -d "$LAST_DATE + 2 days" +%Y-%m-%d 2>/dev/null)
if [ -n "$NEXT" ] && [[ "$TODAY" < "$NEXT" ]]; then
  if [ "$MODE" = "--context" ]; then
    NEXT_PRETTY=$(date -j -v+2d -f "%Y-%m-%d" "$LAST_DATE" "+%B %-d" 2>/dev/null \
              || date -d "$LAST_DATE + 2 days" "+%B %-d" 2>/dev/null)
    echo "GROW_AVAILABLE=false"
    echo "COOLDOWN_MSG=Next /grow available $NEXT_PRETTY."
  fi
  exit 0
fi

# Check 2: weekly cap of 3
if [ -f "$HISTORY" ]; then
  CUTOFF=$(date -j -v-7d +%Y-%m-%d 2>/dev/null \
        || date -d "7 days ago" +%Y-%m-%d 2>/dev/null)
  WEEK_RUNS=0
  while IFS= read -r line; do
    d=$(echo "$line" | grep -o '"date":"[^"]*"' | head -1 | cut -d'"' -f4 | cut -dT -f1)
    [ -n "$d" ] && [[ ! "$d" < "$CUTOFF" ]] && WEEK_RUNS=$((WEEK_RUNS + 1))
  done < "$HISTORY"
  if [ "$WEEK_RUNS" -ge 3 ]; then
    if [ "$MODE" = "--context" ]; then
      echo "GROW_AVAILABLE=false"
      echo "COOLDOWN_MSG=You've had 3 recommendations this week. Try again in a few days."
    fi
    exit 0
  fi
fi

# Available
if [ "$MODE" = "--context" ]; then
  echo "GROW_AVAILABLE=true"
else
  printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"/grow is ready"}}\n'
fi
