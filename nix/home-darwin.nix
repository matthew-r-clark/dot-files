{ config, pkgs, ... }:
{
  home.username = "matthew.clark";
  home.homeDirectory = "/Users/matthew.clark";

  home.packages = with pkgs; [
  #   docker-client
  #   docker-compose
    lazydocker
  #   redis
  #   stripe-cli
  #   imagemagick
  #   graphicsmagick
  #   ghostscript # PostScript and PDF interpreter

  #   # mobile dev
  #   cocoapods
  #   xcodes
  #   idb-companion


  # # full list from running `brew list --installed-on-request`
  # aria2
  # btop
  # cocoapods
  # deno
  # dnsmasq
  # edencommon
  # fb303
  # ffmpeg
  # fizz
  # folly
  # git-who
  # idb-companion
  # jq
  # lazygit
  # librist
  # libyaml
  # mas
  # meson
  # neovim
  # node-build
  # nodenv
  # openjdk@11
  # openjdk@17
  # parallel
  # postgresql@14
  # pyenv
  # python@3.12
  # rbenv
  # scrcpy
  # stripe
  # tmux
  # uv
  # wangle
  # watchman
  # xcodes
  ];

  # ---------------------------------------------------------------------------
  # Phase 3: macOS-specific shell additions.
  # Add to programs.zsh.initExtra after migrating .zshrc in Phase 3.
  # ---------------------------------------------------------------------------
  # programs.zsh.initExtra = ''
  #   # Android SDK
  #   export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
  #   export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
  #   export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
  #
  #   # Version managers (kept until fully migrated to Nix)
  #   eval "$(nodenv init -)"
  #   eval "$(rbenv init - zsh)"
  # '';
}
