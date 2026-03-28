{ pkgs, ... }:
{
  # home.stateVersion — do not change after first activation
  home.stateVersion = "24.05";

  imports = [
    ./modules/symlinks.nix
    ./modules/git.nix
    ./modules/tmux.nix
  ];

  home.packages = with pkgs; [
    # --- shells & editors ---
    zsh
    neovim

    # --- CLI utilities ---
    btop
    ripgrep
    fd
    httpie
    scrcpy
    lazygit
    posting
    dnsmasq

    # --- language version managers ---
    nodenv
    rbenv
    pyenv

    # --- language runtimes ---
    cargo
    lua
    luajit
    luarocks

    # --- formatters & linters ---
    prettierd
    quick-lint-js

    # --- QMK keyboard tools (uncomment when needed) ---
    #   qmk
    #   avrdude
    #   dfu-programmer
    #   dfu-util
    #   teensy-loader-cli
  ];
}
