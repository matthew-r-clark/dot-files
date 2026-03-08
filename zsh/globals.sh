#!/bin/zsh
# shellcheck shell=bash

# taillight
export ODY_ENV=true

export EDITOR='nvim'
export COLORTERM=truecolor

# git-delta options
export DELTA_PAGER='less -+X -+F --mouse'

# export PATH=$PATH:$HOME/.pyenv/shims:$HOME/bin:/usr/local/bin:/$HOME/.mvn/apache-maven-3.8.6/bin:/$PATH
# add pyenv to path
export PATH=$PATH:$HOME/.pyenv/shims
# add bin dirs to path
export PATH=$PATH:$HOME/bin:/usr/local/bin
# add maven to path
export PATH=$PATH:$HOME/.mvn/apache-maven-3.8.6/bin
# add claude to path
export PATH=$PATH:$HOME/.local/bin
# add custom cli tools to path
export PATH=$PATH:$HOME/dot-files/cli-tools

# https://reactnative.dev/docs/environment-setup#cocoapods
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
