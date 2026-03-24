#!/bin/zsh
# shellcheck shell=bash

# disables "appears unused" warning for file
# shellcheck disable=SC2034

# Install Alien if not found
if [ ! -f ~/alien/alien.zsh ]; then
    TEMP_DIR=$PWD
    cd ~ || exit
    git clone https://github.com/eendroroy/alien.git
    cd alien || exit
    git submodule update --init --recursive
    cd "$TEMP_DIR" || exit
fi

# shellcheck source=/Users/matthew.clark/alien/alien.zsh
source "$HOME/alien/alien.zsh"

export ALIEN_SECTIONS_LEFT=(
    exit
    # user
    path
    vcs_branch:async
    vcs_status:async
    vcs_dirty:async
    newline
    ssh
    venv
    versions
    prompt
)

export ALIEN_SECTIONS_RIGHT=(
    time
)

# Color definitions (https://www.nordtheme.com/docs/colors-and-palettes)
# Polar Night (dark gray)
background_color="#181E2A" # darker than nord0, used for inactive panes
inactive_background_color="#2E3440" # nord0, darkest
elevated_background_color="#3B4252" # nord1 (also good for border, drop shadow, etc)
selection_color="#434C5E" # nord2
guide_marker_color="#4C566A" # nord3, lightest

# Snow Storm (light gray or offwhite)
subtext_color="#D8DEE9" #nord4, darkest
text_color="#E5E9F0" #nord5
elevated_text_color="#ECEFF4" #nord6, lightest

# Frost (blues)
primary_action_accent_color="#8FBCBB" # nord7
primary_action_color="#88C0D0" # nord8
secondary_action_color="#81A1C1" # nord9
tertiary_action_color="#5E81AC" # nord10

# Aurora (other colors)
error_color="#BF616A" # red, nord11
danger_color="#D08770" # orange, nord12
warning_color="#EBCB8B" # yellow, nord13
success_color="#A3BE8C" # green, nord14
uncommon_color="#B48EAD" # purple, nord15

export ALIEN_SECTIONS_LEFT_SEP_SYM=""
export ALIEN_SECTIONS_RIGHT_SEP_SYM=""

export ALIEN_VERSIONS_PROMPT='NODE'
export ALIEN_PROMPT_FG=$primary_action_color
export ALIEN_SECTION_EXIT_FG=$subtext_color
export ALIEN_SECTION_EXIT_BG=$background_color
export ALIEN_SECTION_EXIT_BG_ERROR=$error_color
export ALIEN_SECTION_USER_FG=$background_color
export ALIEN_SECTION_USER_BG=$primary_action_color
export ALIEN_SECTION_PATH_FG=$primary_action_color
export ALIEN_SECTION_PATH_BG=$guide_marker_color
export ALIEN_SECTION_VCS_BRANCH_FG=$primary_action_color
export ALIEN_SECTION_VCS_BRANCH_BG=$selection_color
export ALIEN_SECTION_VCS_STATUS_FG=$background_color
export ALIEN_SECTION_VCS_STATUS_BG=$primary_action_color
export ALIEN_SECTION_VCS_DIRTY_FG=$success_color
export ALIEN_SECTION_VCS_DIRTY_BG=$elevated_background_color
export ALIEN_GIT_TRACKED_COLOR=$success_color
export ALIEN_GIT_UN_TRACKED_COLOR=$error_color
export ALIEN_SECTION_SSH_FG=$text_color
export ALIEN_SECTION_VENV_FG=$text_color
export ALIEN_SECTION_VERSION_BG=$elevated_background_color
export ALIEN_NODE_COLOR=$primary_action_accent_color
export ALIEN_SECTION_TIME_FG=$background_color
export ALIEN_SECTION_TIME_BG=$primary_action_color
export ALIEN_USE_NERD_FONT=1
