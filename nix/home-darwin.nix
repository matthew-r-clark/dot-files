{ config, pkgs, lib, ... }:
{
  home.username = "matthew.clark";
  home.homeDirectory = "/Users/matthew.clark";

  home.file = {
    "Library/Application Support/lazygit/config.yml".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/lazygit/config.yml";
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
    docker
    docker-compose
    lazydocker
    ghostty-bin

    rectangle
    redis
    stripe-cli
    imagemagick
  #   graphicsmagick
  #   ghostscript # PostScript and PDF interpreter

  #   # mobile dev
  #   cocoapods
  #   xcodes
  #   idb-companion


  # # other apps from running `brew list --installed-on-request`
  # aria2
  # deno
  # edencommon
  # fb303
  # ffmpeg
  # fizz
  # folly
  # git-who
  # idb-companion
  # jq
  # librist
  # libyaml
  # mas
  # meson
  # node-build
  # parallel
  # postgresql@14
  # python@3.12
  # uv
  # wangle
  # watchman
  ];
}
