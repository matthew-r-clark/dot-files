{ config, pkgs, ... }:
{
  home.username = "matthew.clark";
  home.homeDirectory = "/home/matthew.clark";

  # ---------------------------------------------------------------------------
  # Packages — add Linux-specific tools here as needed.
  # Cross-platform tools go in home-shared.nix instead.
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
      ghostty
  ];

  programs.zsh.shellAliases = {
    nix-update = "cd $DOTFILE_DIR && nix flake update && home-manager switch --flake .";
  };

  # ---------------------------------------------------------------------------
  # Linux-specific shell config (Phase 3+)
  # ---------------------------------------------------------------------------
  # programs.zsh.initContent = ''
  # '';
}
