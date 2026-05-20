#!/usr/bin/env bash
set -euo pipefail

config="$HOME/.claude.json"
[ ! -f "$config" ] && echo '{}' > "$config"

envfile="$HOME/dot-files/claude/testmo-secrets.env"
script="$HOME/development/taillight/mcp-servers/testmo/src/index.js"

managed_server=$(jq -n \
  --arg envfile "$envfile" \
  --arg script "$script" \
  '{testmo: {
     type: "stdio",
     command: "op",
     args: ["run", "--env-file=" + $envfile, "--", "node", $script]
   }}')

tmp=$(mktemp)
jq --argjson srv "$managed_server" \
  '.mcpServers = ((.mcpServers // {}) + $srv)' \
  "$config" > "$tmp" && mv "$tmp" "$config"

echo "✓ testmo MCP configured in ~/.claude.json"
