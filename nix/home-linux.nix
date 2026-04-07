{ config, pkgs, ... }:
{
  home.username = "matt";
  home.homeDirectory = "/home/matt";

  # ---------------------------------------------------------------------------
  # Packages — add Linux-specific tools here as needed.
  # Cross-platform tools go in home-shared.nix instead.
  # ---------------------------------------------------------------------------
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.inconsolata
  ];

  programs.zsh.shellAliases = {
    nix-rebuild  = "cd $DOTFILE_DIR && home-manager switch --flake . -b bak";
    nix-update   = "cd $DOTFILE_DIR && nix flake update && home-manager switch --flake .";
    nix-rollback = "home-manager generations";
    nix-gc       = "nix-collect-garbage -d";
  };

  # ---------------------------------------------------------------------------
  # Linux-specific shell config (Phase 3+)
  # ---------------------------------------------------------------------------
  # programs.zsh.initContent = ''
  # '';
}
