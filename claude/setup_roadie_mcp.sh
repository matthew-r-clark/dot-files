#!/bin/bash

JIRA_API_TOKEN=$(security find-generic-password -a "$USER" -s "jira-api-token" -w 2>/dev/null || true)
BITBUCKET_API_TOKEN=$(security find-generic-password -a "$USER" -s "bitbucket-api-token" -w 2>/dev/null || true)
claude mcp add \
    --transport http roadie http://localhost:2058/mcp \
    --header "X-Jira-Token: ${JIRA_API_TOKEN}" \
    --header "X-Bitbucket-Token: ${BITBUCKET_API_TOKEN}"
