{ config, lib, pkgs, ... }:
{
  # home.stateVersion — do not change after first activation
  home.stateVersion = "24.05";

  # ---------------------------------------------------------------------------
  # Dotfile symlinks
  # Uses mkOutOfStoreSymlink so edits in ~/dot-files are reflected immediately,
  # matching the original create-symlinks.sh behaviour.
  # ---------------------------------------------------------------------------
  home.file = {
    ".tmux.conf".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/.tmux.conf";

    ".gitconfig".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/.gitconfig";

    ".gitignore".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/.gitignore";

    ".zshrc".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/.zshrc";

    ".claude/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/claude/settings.json";

    ".claude/custom".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/claude/custom";
  };

  xdg.configFile = {
    "nvim/init.lua".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/init.lua";

    "nvim/lua".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/lua";

    "nvim/snippets".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/snippets";

    "ghostty".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/ghostty";
  };

  home.packages = with pkgs; [
    btop
    ripgrep
    fd
    git
    delta
    httpie
    scrcpy
    lazygit
    posting

    tmux
    neovim
    cargo
    #   nodenv
    #   rbenv
    #   pyenv

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
  ];

  # lazy-lock.json must stay writable for lazy.nvim plugin updates.
  # Create a direct (non-store) symlink via activation instead of home.file.
  home.activation.nvimLazyLock = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf "$HOME/dot-files/lua/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"
  '';
}
