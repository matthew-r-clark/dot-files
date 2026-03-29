{ config, pkgs, lib, ... }:
{
  home.username = "matthew.clark";
  home.homeDirectory = "/Users/matthew.clark";

  programs.zsh.shellAliases = {
    nix-update = "cd $DOTFILE_DIR && nix flake update && sudo darwin-rebuild switch --flake .";
  };

  home.activation.ghosttyApp = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir -p "$HOME/Applications"
    # The nix store is read-only (555/444), so the existing copy must be unlocked before rm can delete it.
    [ -d "$HOME/Applications/Ghostty.app" ] && run chmod -R u+w "$HOME/Applications/Ghostty.app"
    run rm -rf "$HOME/Applications/Ghostty.app"
    # Copy with -L to dereference symlinks, producing a real app bundle (not a symlink chain) for Spotlight.
    run cp -rL "${pkgs.ghostty-bin}/Applications/Ghostty.app" "$HOME/Applications/Ghostty.app"
    # Spotlight's metadata importer writes extended attributes to index the app; requires write permission.
    run chmod -R u+w "$HOME/Applications/Ghostty.app"
    # Trigger Spotlight indexing immediately rather than waiting for background mdworker to pick it up.
    run /usr/bin/mdimport "$HOME/Applications/Ghostty.app"
  '';

  home.packages = with pkgs; [
    # --- terminal ---
    ghostty-bin

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
