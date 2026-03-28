{ config, lib, ... }:
{
  programs.neovim.enable = true;

  # Symlink the full neovim config from the dotfiles repo so edits are live.
  # Plugin management is handled by lazy.nvim inside the config itself.
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
  };

  # lazy-lock.json must stay writable for lazy.nvim to update it.
  # A direct (non-store) symlink is required so lazy.nvim can overwrite it.
  home.activation.nvimLazyLock = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf "$HOME/dot-files/lua/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"
  '';
}
