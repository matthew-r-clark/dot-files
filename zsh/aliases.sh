#!/bin/zsh
# shellcheck shell=bash

# general
alias c="clear"
alias rg="rg --hidden -g '!.git'"

# docker
alias docker-compose="docker compose"
alias dc="docker compose"
alias dcu="dc up -d"
alias dcd="dc down"
alias dcr="dc restart"
alias dcl="dc logs -f"
alias dcps="clear; dc ps;"
alias lzd="lazydocker"

# neovim
alias n="nvim +\"silent! :source Session.vim\""
alias vw="nvim ~/vimwiki/index.wiki"
alias nvimlogs="tail -n 1000 -f logger.txt"

# scripts
alias gendockerfile="~/development/taillight/od-env/build-node-docker/gendockerfile.sh"
alias renderconsul="~/development/taillight/od-env/build-node-docker/render-consul-template.sh"

# git
# alias gbc="git branch -d $(echo `git branch --merged | grep -v $(git branch --show-current)`)"
alias lzg="lazygit"

# ampy
alias py="ampy --port /dev/tty.usbmodem401101"
alias pyg="py get"
alias pyp="py put"
alias pyr="py run"
alias pyd="py rm"
alias pyl="py ls"
alias pyu="~/development/raspi/pyboard/download-file.sh"
