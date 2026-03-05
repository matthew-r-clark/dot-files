#!/usr/bin/env bash

# this is just an example for future reference, you will need to add the key here
security add-generic-password -a "$USER" -s claude-api-key -w "sk-ant-....."
security add-generic-password -a "$USER" -s open-ai-api-key -w "sk-proj-....."
