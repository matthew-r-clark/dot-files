git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

PS1=""
PS1+="\[\e[0;95m\]\W\[\e[m\]"
PS1+="\[\e[0;92m\]\$(git_branch)\[\e[m\]"
PS1+=" > "
export PS1

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias dc="docker-compose"
alias dcu="dc up -d"
alias dcd="dc down"
alias dcr="dc restart"
alias dcl="dc logs -f"

alias gbc="git branch -d $(echo `git branch --merged | grep -v $(git branch --show-current)`)"
