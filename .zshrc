# set dot-files path in env var
export DOTFILE_DIR=$HOME/dot-files

source "$DOTFILE_DIR/zsh/globals.sh"
source "$DOTFILE_DIR/zsh/aliases.sh"
source "$DOTFILE_DIR/zsh/init-oh-my-zsh.sh"
source "$DOTFILE_DIR/zsh/init-alien.sh"

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# nodenv
eval "$(nodenv init -)"

# rbenv
eval "$(rbenv init - zsh)"

