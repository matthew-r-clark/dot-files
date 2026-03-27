{ config, pkgs, ... }:
{
  home.username = "matthew.clark";
  home.homeDirectory = "/home/matthew.clark";

  xdg.configFile = {
    "lazygit/config.yml".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/lazygit/config.yml";
  };

  # ---------------------------------------------------------------------------
  # Packages — add Linux-specific tools here as needed.
  # Cross-platform tools go in home-shared.nix instead.
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
      ghostty
  ];

  # ---------------------------------------------------------------------------
  # Linux-specific shell config (Phase 3+)
  # ---------------------------------------------------------------------------
  # programs.zsh.initExtra = ''
  # '';
}
