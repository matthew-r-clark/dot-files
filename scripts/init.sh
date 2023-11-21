#!/bin/zsh

cd $DOTFILE_DIR # can't do this because the variable doesn't exist yet
git clone git@github.com:matthew-r-clark/dot-files.git
scripts/create-symlinks.sh
brew install `< brew/snapshot`
