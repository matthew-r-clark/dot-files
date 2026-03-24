#!/usr/bin/env bash
# Claude Code status line - inspired by Alien zsh theme with Nord colors

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(jq -r '.model // ""' ~/.claude/settings.json 2>/dev/null)
[ -z "$model" ] && model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')

# Nord color palette (ANSI 256-color approximations)
# nord8  #88C0D0 -> 110 (primary_action_color / cyan-blue)
# nord4  #D8DEE9 -> 188 (subtext_color / light gray)
# nord14 #A3BE8C -> 150 (success_color / green)
# nord11 #BF616A -> 167 (error_color / red)
# nord3  #4C566A -> 59  (guide_marker_color / dark gray)

RESET=$'\033[0m'
CYAN=$'\033[38;5;110m'
GREEN=$'\033[38;5;150m'
DIM=$'\033[38;5;59m'
RED=$'\033[38;5;167m'
BLUE=$'\033[38;5;67m'
ORANGE=$'\033[38;5;173m'
GRAY=$'\033[38;5;102m'

# Shorten home directory to ~, then truncate intermediate components to first char
short_cwd="${cwd/#$HOME/~}"
# Fish-style path truncation: abbreviate all but the last path component to 1 char
short_cwd=$(python3 -c "
import sys
p = sys.argv[1]
parts = p.split('/')
if len(parts) > 1:
    print('/'.join(c[0] if i < len(parts) - 1 and c not in ('', '~') else c for i, c in enumerate(parts)))
else:
    print(p)
" "$short_cwd")

# Git branch and status (skip optional locks)
git_info=""
if git -C "$cwd" rev-parse --is-inside-work-tree --no-optional-locks 2>/dev/null | grep -q true; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        if git -C "$cwd" --no-optional-locks diff --quiet 2>/dev/null && \
           git -C "$cwd" --no-optional-locks diff --cached --quiet 2>/dev/null; then
            git_info=" ${GREEN}${branch}${RESET}"
        else
            git_info=" ${RED}${branch}*${RESET}"
        fi
    fi
fi

# Context window indicator
ctx_info=""
if [ -n "$used" ]; then
    used_int=${used%.*}
    if [ "$used_int" -ge 80 ] 2>/dev/null; then
        ctx_info=" ${RED}${used_int}%${RESET}"
    else
        ctx_info=" ${BLUE}${used_int}%${RESET}"
    fi
fi

# Session cost
cost_info=""
if [ -n "$total_cost" ]; then
    cost_fmt=$(printf '%.2f' "$total_cost" 2>/dev/null || echo "$total_cost")
    cost_info=" ${ORANGE}\$${cost_fmt}${RESET}"
fi

# Model name (shortened)
model_info=""
if [ -n "$model" ]; then
    model_info="${DIM}[${model}]${RESET}"
fi

# Usage limit status (Claude.ai subscription limits)
limit_info=""
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
# Convert a resets_at epoch seconds value to a short absolute time string
# fmt_reset_time: "1p", "11a", "12p" etc.
fmt_reset_time() {
    local reset_ts="${1%%.*}"
    local now_s diff_s
    now_s=$(date +%s)
    diff_s=$(( reset_ts - now_s ))
    if [ "$diff_s" -le 0 ]; then
        echo "now"
        return
    fi
    local hour ampm
    hour=$(date -r "$reset_ts" +%I 2>/dev/null || date -d "@$reset_ts" +%I 2>/dev/null)
    ampm=$(date -r "$reset_ts" +%p 2>/dev/null || date -d "@$reset_ts" +%p 2>/dev/null)
    hour=$(echo "$hour" | sed 's/^0//')
    ampm=$(echo "$ampm" | tr '[:upper:]' '[:lower:]' | sed 's/am/a/;s/pm/p/')
    echo "${hour}${ampm}"
}

# fmt_reset_weektime: "Th@10a", "Mo@2p" etc.
fmt_reset_weektime() {
    local reset_ts="${1%%.*}"
    local now_s diff_s
    now_s=$(date +%s)
    diff_s=$(( reset_ts - now_s ))
    if [ "$diff_s" -le 0 ]; then
        echo "now"
        return
    fi
    local day hour ampm
    day=$(date -r "$reset_ts" +%a 2>/dev/null || date -d "@$reset_ts" +%a 2>/dev/null)
    # Shorten to 2 chars: "Mon" -> "Mo", "Thu" -> "Th" etc.
    day="${day:0:2}"
    hour=$(date -r "$reset_ts" +%I 2>/dev/null || date -d "@$reset_ts" +%I 2>/dev/null)
    ampm=$(date -r "$reset_ts" +%p 2>/dev/null || date -d "@$reset_ts" +%p 2>/dev/null)
    hour=$(echo "$hour" | sed 's/^0//')
    ampm=$(echo "$ampm" | tr '[:upper:]' '[:lower:]' | sed 's/am/a/;s/pm/p/')
    echo "${day}${hour}${ampm}"
}

limit_parts=""
if [ -n "$five_pct" ]; then
    five_int=$(printf '%.0f' "$five_pct")
    five_reset_fmt=""
    [ -n "$five_reset" ] && five_reset_fmt="$(fmt_reset_time "$five_reset")"
    if [ "$five_int" -ge 80 ] 2>/dev/null; then
        limit_parts="${GRAY}5h[${RED}${five_int}%${GRAY}]${five_reset_fmt}${RESET}"
    else
        limit_parts="${GRAY}5h[${GREEN}${five_int}%${GRAY}]${five_reset_fmt}${RESET}"
    fi
fi
if [ -n "$week_pct" ]; then
    week_int=$(printf '%.0f' "$week_pct")
    week_reset_fmt=""
    [ -n "$week_reset" ] && week_reset_fmt="$(fmt_reset_weektime "$week_reset")"
    if [ "$week_int" -ge 80 ] 2>/dev/null; then
        week_seg="${GRAY}7d[${RED}${week_int}%${GRAY}]${week_reset_fmt}${RESET}"
    else
        week_seg="${GRAY}7d[${GREEN}${week_int}%${GRAY}]${week_reset_fmt}${RESET}"
    fi
    [ -n "$limit_parts" ] && limit_parts="${limit_parts} ${week_seg}" || limit_parts="$week_seg"
fi
[ -n "$limit_parts" ] && limit_info="${limit_parts}"

# Session duration
time_info=""
if [ -n "$duration_ms" ]; then
    duration_s=$((duration_ms / 1000))
    hours=$((duration_s / 3600))
    mins=$(( (duration_s % 3600) / 60 ))
    # secs=$((duration_s % 60))
    # duration_fmt="${secs}s"
    duration_fmt=""
    [ "$mins" -gt 0 ] && duration_fmt="${mins}m ${duration_fmt}"
    [ "$hours" -gt 0 ] && duration_fmt="${hours}h ${duration_fmt}"
    time_info="${GRAY}${duration_fmt}${RESET}"
fi

printf "%s%s%s%s %s\n" "$time_info" "$model_info" "$ctx_info" "$cost_info" "$limit_info"
printf "${CYAN}%s${RESET}%s\n" "$short_cwd" "$git_info"
