#!/bin/zsh

DOTFILE_DIR="$HOME/dot-files"

ln -sfF ${DOTFILE_DIR}/init.lua ${HOME}/.config/nvim/init.lua
ln -sfF ${DOTFILE_DIR}/lua ${HOME}/.config/nvim/lua
ln -sfF ${DOTFILE_DIR}/after ${HOME}/.config/nvim/after
ln -sfF ${DOTFILE_DIR}/snippets ${HOME}/.config/nvim/snippets
ln -sfF ${DOTFILE_DIR}/.gitconfig ${HOME}/.gitconfig
ln -sfF ${DOTFILE_DIR}/.gitignore ${HOME}/.gitignore
ln -sfF ${DOTFILE_DIR}/.tmux.conf ${HOME}/.tmux.conf
ln -sfF ${DOTFILE_DIR}/.zshrc ${HOME}/.zshrc
