{ config, pkgs, ... }:
{
  home.username = "matthew.clark";
  home.homeDirectory = "/Users/matthew.clark";

  home.sessionVariables = {
    ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Library/Android/sdk";
  };

  home.sessionPath = [
    "/usr/local/bin"
    "/opt/homebrew/bin"
    "${config.home.homeDirectory}/Library/Android/sdk/emulator"
    "${config.home.homeDirectory}/Library/Android/sdk/platform-tools"
  ];

  programs.zsh.shellAliases = {
    nix-rebuild       = "cd $DOTFILE_DIR && sudo darwin-rebuild switch --flake .#mac";
    nix-update        = "cd $DOTFILE_DIR && nix flake update && sudo darwin-rebuild switch --flake .#mac";
    nix-rollback      = "sudo darwin-rebuild --rollback";
    nix-gc            = "sudo nix-collect-garbage -d";
    lazyclaude-update = "CARGO_NET_GIT_FETCH_WITH_CLI=true cargo install --git ssh://git@bitbucket.internal.taillight.cloud:7999/~clarkm/lazyclaude.git";
  };

  home.file."Library/Application Support/lazydocker".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dot-files/lazydocker";

  home.file.".docker/cli-plugins/docker-compose" = {
    source = "${pkgs.docker-compose}/libexec/docker/cli-plugins/docker-compose";
  };

  home.file.".docker/cli-plugins/docker-buildx" = {
    source = "${pkgs.docker-buildx}/libexec/docker/cli-plugins/docker-buildx";
  };

  home.packages = with pkgs; [
    # --- fonts ---
    nerd-fonts.inconsolata
    nerd-fonts.hack

    # --- containers ---
    colima
    docker
    docker-buildx
    docker-compose
    lazydocker

    # --- macOS utilities ---
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
