#!/usr/bin/env bash
set -euo pipefail

config="$HOME/.claude.json"
[ ! -f "$config" ] && echo '{}' > "$config"

managed_server=$(jq -n \
  '{"roadie-dev": {
     type: "http",
     url: "https://tloroadiemcpapi.dev.taillight.xyz/mcp",
     headersHelper: "/etc/profiles/per-user/matthew.clark/bin/roadie-headers"
   }}')

tmp=$(mktemp)
jq --argjson srv "$managed_server" \
  '.mcpServers = ((.mcpServers // {}) + $srv)' \
  "$config" > "$tmp" && mv "$tmp" "$config"

echo "✓ roadie-dev MCP configured in ~/.claude.json"
