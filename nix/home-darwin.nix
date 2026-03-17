{ config, pkgs, ... }:
{
  home.username = "matthew.clark";
  home.homeDirectory = "/Users/matthew.clark";

  home.file = {
    "Library/Application Support/lazygit/config.yml".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/lazygit/config.yml";
  };

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


  # # other apps from running `brew list --installed-on-request`
  # aria2
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
  # librist
  # libyaml
  # mas
  # meson
  # node-build
  # parallel
  # postgresql@14
  # python@3.12
  # stripe
  # uv
  # wangle
  # watchman
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
