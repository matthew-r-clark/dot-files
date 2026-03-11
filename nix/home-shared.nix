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

  # Notes from Claude on upgrading nvim and tmux:
  
  # General approach
  
  #   1. Test the Nix version without installing it:
  #   nix run nixpkgs#tmux
  #   nix run nixpkgs#neovim
  #   1. This runs the Nix version temporarily without touching your Homebrew install. Poke around, open files, test your config, restore sessions, etc.
  #   2. Identify what breaks — fix the config issue in your dotfiles repo first, so the fix is in place before you switch permanently.
  #   3. Once config is fixed, add to Nix, run darwin-rebuild switch, verify, then brew uninstall.
  
  #   ---
  #   tmux specifically
  
  #   The 3.5a → 3.6a breakage with vim-obsession is worth investigating in the https://github.com/tmux/tmux/blob/master/CHANGES. It's likely one config
  #   option was renamed or a default changed. Usually a one-line fix in .tmux.conf.
  
  #   neovim specifically
  
  #   0.10 → 0.11 is trickier. The cleanest approach:
  #   1. Run nix run nixpkgs#neovim and open a TypeScript file
  #   2. Watch for deprecation warnings — :messages will show them
  #   3. Check health: :checkhealth
  #   4. Fix any issues in the lua config before switching permanently
  
  #   The main 0.11 breaking changes to watch for are around vim.lsp defaults (inlay hints on by default, some LSP attach patterns changed) and some
  #   deprecated vim.api calls that were removed.

  home.packages = with pkgs; [
    # neovim
    # tmux
    # tree-sitter
    ripgrep
    fd
    git
    delta
    httpie
    posting

    #   # Formatters / linters
    #   prettierd
    #   # quick-lint-js  # check availability in nixpkgs

    #   # Languages
    #   lua
    #   luajit
    #   luarocks
    #   nodenv
    #   rbenv
    #   pyenv

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
