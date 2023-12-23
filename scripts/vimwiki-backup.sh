#!/bin/bash

cd ~/vimwiki
git add .

STAGED_CHANGES=$(git diff --staged)

if [ -z "$STAGED_CHANGES" ]
then
    echo "\n$(date): No changes, skipping backup" >> ~/.vimwiki-auto-backup-log &> /dev/null
else
    echo "\n" >> ~/.vimwiki-auto-backup-log &> /dev/null
    git commit -m "$(date): Automatic backup" >> ~/.vimwiki-auto-backup-log &> /dev/null
    git push >> ~/.vimwiki-auto-backup-log &> /dev/null
fi
