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

# Shorten home directory to ~
short_cwd="${cwd/#$HOME/~}"

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

# Session duration
time_info=""
if [ -n "$duration_ms" ]; then
    duration_s=$((duration_ms / 1000))
    hours=$((duration_s / 3600))
    mins=$(( (duration_s % 3600) / 60 ))
    secs=$((duration_s % 60))
    duration_fmt="${secs}s"
    [ "$mins" -gt 0 ] && duration_fmt="${mins}m ${duration_fmt}"
    [ "$hours" -gt 0 ] && duration_fmt="${hours}h ${duration_fmt}"
    time_info="${GRAY}${duration_fmt}${RESET}"
fi

printf "%s%s%s %s\n" "$model_info" "$ctx_info" "$cost_info" "$time_info"
printf "${CYAN}%s${RESET}%s\n" "$short_cwd" "$git_info"
