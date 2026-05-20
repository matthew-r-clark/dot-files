{ config, lib, ... }:
{
  home.activation.testmoMcpServer =
    lib.hm.dag.entryAfter [ "claudeMcpServers" ] ''
      $DRY_RUN_CMD bash "${config.home.homeDirectory}/dot-files/claude/testmo-mcp.sh"
    '';
}
