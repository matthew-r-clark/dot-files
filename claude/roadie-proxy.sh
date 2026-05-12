#!/usr/bin/env bash
set -euo pipefail

ROADIE_ENV=$(cat "${HOME}/.claude/roadie-env" 2>/dev/null || echo "prd")

case "${ROADIE_ENV}" in
  od-env) ROADIE_URL="http://tloroadiemcpapi.localhost/mcp" ;;
  dev)    ROADIE_URL="https://tloroadiemcpapi.dev.taillight.xyz/mcp" ;;
  qa)     ROADIE_URL="https://tloroadiemcpapi.qa.taillight.xyz/mcp" ;;
  prd)    ROADIE_URL="https://tloroadiemcpapi.prd.taillight.com/mcp" ;;
  *) echo "Unknown env: ${ROADIE_ENV}" >&2; exit 1 ;;
esac

exec op run --env-file="${HOME}/dot-files/claude/roadie-secrets.env" -- npx mcp-remote@0.1.38 "${ROADIE_URL}" \
  --header 'X-Jira-Token: ${JIRA_TOKEN}' \
  --header 'X-Bitbucket-Token: ${BITBUCKET_TOKEN}' \
  --silent
