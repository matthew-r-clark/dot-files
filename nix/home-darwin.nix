{ config, pkgs, ... }:
{
  home.username = "matthew.clark";
  home.homeDirectory = "/Users/matthew.clark";

  # ---------------------------------------------------------------------------
  # Packages — Phase 4: migrate from Homebrew one tool at a time.
  # Uncomment each line after: brew uninstall <tool> --ignore-dependencies
  # ---------------------------------------------------------------------------
  # home.packages = with pkgs; [
  #   # Core CLI
  #   neovim
  #   tmux
  #   ripgrep
  #   fd
  #   git
  #   delta
  #   httpie
  #   tree-sitter

  #   # Formatters / linters
  #   prettierd
  #   # quick-lint-js  # check availability in nixpkgs

  #   # Languages
  #   lua
  #   luajit
  #   luarocks

  #   # QMK keyboard tools (shared with Linux)
  #   qmk
  #   avrdude
  #   dfu-programmer
  #   dfu-util
  #   teensy-loader-cli

  #   # macOS-only: Docker & containers
  #   docker-client
  #   docker-compose
  #   lazydocker

  #   # macOS-only: work infra
  #   redis
  #   stripe-cli

  #   # macOS-only: image processing
  #   imagemagick
  #   graphicsmagick
  #   ghostscript

  #   # macOS-only: mobile dev
  #   cocoapods
  #   xcodes
  # ];

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
