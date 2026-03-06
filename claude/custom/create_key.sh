#!/usr/bin/env bash

# this is just an example for future reference, you will need to add the key here
security add-generic-password -a "$USER" -s claude-api-key -w "sk-ant-....."
security add-generic-password -a "$USER" -s open-ai-api-key -w "sk-proj-....."

# these are exported as JIRA_API_TOKEN and BITBUCKET_API_TOKEN in ~/.zshrc
security add-generic-password -a "$USER" -s jira-api-token -w "your_jira_token"
security add-generic-password -a "$USER" -s bitbucket-api-token -w "your_bitbucket_token"
