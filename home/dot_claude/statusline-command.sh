#!/bin/sh
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
branch=$(git -C "$(echo "$input" | jq -r '.workspace.current_dir')" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
session_id=$(echo "$input" | jq -r '.session_id // empty')

input_tokens=$(echo "$input" | jq -r '(.context_window.current_usage.input_tokens // 0) + (.context_window.current_usage.cache_read_input_tokens // 0) + (.context_window.current_usage.cache_creation_input_tokens // 0)')

# ANSI color codes
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
MAGENTA='\033[0;35m'
DIM='\033[2m'
RESET='\033[0m'

# Model — cyan
model_str=$(printf "${CYAN}%s${RESET}" "$model")

# Context — yellow
ctx_str=""
if [ -n "$used" ]; then
  pct=$(printf '%.1f' "$used")
  if [ -n "$input_tokens" ] && [ "$input_tokens" != "0" ]; then
    k_tokens=$(awk "BEGIN { printf \"%.1fk\", $input_tokens / 1000 }")
    ctx_str=$(printf " ${DIM}|${RESET} ${YELLOW}ctx: %s%% · %s tokens${RESET}" "$pct" "$k_tokens")
  else
    ctx_str=$(printf " ${DIM}|${RESET} ${YELLOW}ctx: %s%%${RESET}" "$pct")
  fi
fi

# Branch — green
branch_str=""
if [ -n "$branch" ]; then
  branch_str=$(printf " ${DIM}|${RESET} ${GREEN}🌿 %s${RESET}" "$branch")
fi

# Timer — magenta
timer_str=""
if [ -n "$session_id" ]; then
  session_file="/tmp/claude-session-start-${session_id}"
  now=$(date +%s)
  if [ ! -f "$session_file" ]; then
    echo "$now" > "$session_file"
    start=$now
  else
    start=$(cat "$session_file")
  fi
  elapsed=$(( now - start ))
  elapsed_min=$(( elapsed / 60 ))
  if [ "$elapsed_min" -lt 60 ]; then
    timer_str=$(printf " ${DIM}|${RESET} ${MAGENTA}⏱ %sm${RESET}" "$elapsed_min")
  else
    elapsed_hr=$(( elapsed_min / 60 ))
    remaining_min=$(( elapsed_min % 60 ))
    timer_str=$(printf " ${DIM}|${RESET} ${MAGENTA}⏱ %sh%sm${RESET}" "$elapsed_hr" "$remaining_min")
  fi
fi

printf "%b%b%b%b\n" "$model_str" "$ctx_str" "$branch_str" "$timer_str"
