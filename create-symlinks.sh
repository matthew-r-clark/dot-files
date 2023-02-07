#!/bin/zsh

DOTFILE_DIR=/Users/clarkm/dot-files

ln -sfF ${DOTFILE_DIR}/init.lua ~/.config/nvim/init.lua
ln -sfF ${DOTFILE_DIR}/lua ~/.config/nvim
ln -sfF ${DOTFILE_DIR}/after ~/.config/nvim
ln -sfF ${DOTFILE_DIR}/snippets ~/.config/nvim
ln -sfF ${DOTFILE_DIR}/.gitconfig ~/.gitconfig
ln -sfF ${DOTFILE_DIR}/.gitignore ~/.gitignore
ln -sfF ${DOTFILE_DIR}/.tmux.conf ~/.tmux.conf
ln -sfF ${DOTFILE_DIR}/.zshrc ~/.zshrc
