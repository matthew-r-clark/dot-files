{ pkgs, ... }:
{
  # home.stateVersion — do not change after first activation
  home.stateVersion = "24.05";

  imports = [
    ./modules/symlinks.nix
    ./modules/git.nix
    ./modules/tmux.nix
    ./modules/neovim.nix
  ];

  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    # --- shells & editors ---
    zsh

    # --- CLI utilities ---
    btop
    ripgrep
    fd
    httpie
    scrcpy
    posting
    dnsmasq

    # --- language version managers ---
    nodenv
    rbenv
    pyenv

    # --- language runtimes ---
    cargo
    luajit  # provides lua binary; conflicts with pkgs.lua
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
