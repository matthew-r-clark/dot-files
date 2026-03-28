{ config, lib, ... }:
{
  # ---------------------------------------------------------------------------
  # Dotfile symlinks
  # Uses mkOutOfStoreSymlink so edits in ~/dot-files are reflected immediately
  # without requiring a rebuild.
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

    ".claude/CLAUDE.md".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/claude/CLAUDE.md";

    ".claude/skills".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/claude/skills";
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

  # lazy-lock.json must stay writable for lazy.nvim plugin updates.
  # A direct (non-store) symlink is used so lazy.nvim can overwrite it.
  home.activation.nvimLazyLock = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf "$HOME/dot-files/lua/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"
  '';
}
