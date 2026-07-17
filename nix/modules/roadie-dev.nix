{ config, lib, ... }:
{
  home.activation.roadieDevMcpServer =
    lib.hm.dag.entryAfter [ "claudeMcpServers" ] ''
      $DRY_RUN_CMD bash "${config.home.homeDirectory}/dot-files/claude/roadie-dev-mcp.sh"
    '';
}
