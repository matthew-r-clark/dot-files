{ config, pkgs, ... }:
{
  home.username = "matthew.clark";
  home.homeDirectory = "/Users/matthew.clark";

  programs.zsh.shellAliases = {
    nix-rebuild  = "cd $DOTFILE_DIR && sudo darwin-rebuild switch --flake .";
    nix-update   = "cd $DOTFILE_DIR && nix flake update && sudo darwin-rebuild switch --flake .";
    nix-rollback = "sudo darwin-rebuild --rollback";
    nix-gc       = "sudo nix-collect-garbage -d";
  };

  home.packages = with pkgs; [
    # --- fonts ---
    nerd-fonts.inconsolata

    # --- containers ---
    docker
    docker-compose
    lazydocker

    # --- macOS utilities ---
    rectangle
    redis
    stripe-cli
    imagemagick
    #   graphicsmagick
    #   ghostscript # PostScript and PDF interpreter

    # --- mobile dev (uncomment when needed) ---
    #   cocoapods
    #   xcodes
    #   idb-companion

    # --- not yet migrated from brew (uncomment + test each) ---
    #   aria2
    #   deno
    #   ffmpeg
    #   jq
    #   postgresql # was postgresql@14
    #   python312  # was python@3.12
    #   uv
    #   watchman
  ];
}
