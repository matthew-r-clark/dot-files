#!/bin/bash

mkdir ${DOTFILE_DIR}/brew/
brew list > ${DOTFILE_DIR}/brew/snapshot
