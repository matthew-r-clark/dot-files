{ pkgs, ... }:
{
  # home.stateVersion — do not change after first activation
  home.stateVersion = "24.05";

  imports = [
    ./modules/symlinks.nix
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/tmux.nix
    ./modules/neovim.nix
    ./modules/starship.nix
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        selectedLineBgColor  = [ "#434C5E" ];
        selectedRangeBgColor = [ "#434C5E" ];
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # Use fd for file listing: faster, respects .gitignore, shows hidden files
    defaultCommand = "fd --type f --hidden --exclude .git";
    defaultOptions = [ "--height 40%" "--border" ];
  };

  home.packages = with pkgs; [
    # --- CLI utilities ---
    btop
    ripgrep
    fd
    jq
    httpie
    scrcpy
    posting

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

    _1password-gui
    _1password-cli

    # --- QMK keyboard tools (uncomment when needed) ---
    #   qmk
    #   avrdude
    #   dfu-programmer
    #   dfu-util
    #   teensy-loader-cli
  ];
}
