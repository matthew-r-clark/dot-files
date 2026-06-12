#!/usr/bin/env bash
set -euo pipefail

config="$HOME/.claude.json"
[ ! -f "$config" ] && echo '{}' > "$config"

script="$HOME/development/projects/testmo-mcp/src/index.js"

managed_server=$(jq -n \
  --arg script "$script" \
  '{testmo: {
     type: "stdio",
     command: "op",
     args: ["run", "--", "node", $script],
     env: {
       TESTMO_API_KEY: "op://Employee/Testmo API/credential",
       TESTMO_BASE_URL: "https://taillight.testmo.net"
     }
   }}')

tmp=$(mktemp)
jq --argjson srv "$managed_server" \
  '.mcpServers = ((.mcpServers // {}) + $srv)' \
  "$config" > "$tmp" && mv "$tmp" "$config"

echo "✓ testmo MCP configured in ~/.claude.json"
