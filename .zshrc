plugins=(git nvm)

alias c="clear"
alias dc="docker-compose"
alias dcu="dc up -d"
alias dcd="dc down"
alias dcr="dc restart"
alias dcl="dc logs -f"
alias dcps="clear; dc ps;"
alias lzd="lazydocker"
alias n="nvim +\"silent! :source Session.vim\""
alias vw="nvim ~/vimwiki/index.wiki"
export ODY_ENV=true
alias gendockerfile="~/development/od-env/build-node-docker/gendockerfile.sh"
alias renderconsul="~/development/od-env/build-node-docker/render-consul-template.sh"
alias nvimlogs="tail -n 1000 -f logger.txt"

# alias gbc="git branch -d $(echo `git branch --merged | grep -v $(git branch --show-current)`)"
alias py="ampy --port /dev/tty.usbmodem401101"
alias pyg="py get"
alias pyp="py put"
alias pyr="py run"
alias pyd="py rm"
alias pyl="py ls"
alias pyu="~/development/raspi/pyboard/download-file.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Install Alien if not found
if [ ! -f ~/alien/alien.zsh ]; then
    TEMP_DIR=$PWD
    cd ~
    git clone https://github.com/eendroroy/alien.git
    cd alien
    git submodule update --init --recursive
    cd $TEMP_DIR 
fi

source ~/alien/alien.zsh

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
background_color="#2E3440" # nord0, darkest
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

export PATH=$HOME/bin:/usr/local/bin:/$HOME/.mvn/apache-maven-3.8.6/bin:/$PATH
export EDITOR='nvim'
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

ENABLE_CORRECTION="true"

# initialize shell with correct version of node for project if .nvmrc exists, otherwise use default
NVMRC=.nvmrc
if [ -f "$NVMRC" ]; then
    nvm use && clear
else
    nvm use default && clear
fi

source $HOME/.docker/init-zsh.sh || true # Added by Docker Desktop

CUSTOM_CLI_TOOLS_PATH=$HOME/dot-files/cli-tools
export PATH=$PATH:$CUSTOM_CLI_TOOLS_PATH

export DOTFILE_DIR=$HOME/dot-files
