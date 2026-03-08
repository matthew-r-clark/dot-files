#!/bin/zsh
# shellcheck shell=bash

# disables "appears unused" warning for file
# shellcheck disable=SC2034

# adds git aliases for oh-my-zsh, must be before sourcing oh-my-zsh script
plugins=(git nvm)

# extend oh-my-zsh alias gsts (git stash show --patch) to include untracked files
alias gstv="gsts -u"

export ZSH="$HOME/.oh-my-zsh"

# Since shellcheck doesn't support zsh it can't parse this file.
# shellcheck source=/dev/null
source "$ZSH/oh-my-zsh.sh"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
