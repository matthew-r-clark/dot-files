#!/bin/zsh

cd ~/vimwiki
git add .

STAGED_CHANGES=$(git diff --staged)

if [ -z "$STAGED_CHANGES" ]
then
    echo "No changes, skipping backup"
else
    git commit -m "automatic backup on $(date)"
    git push
fi
