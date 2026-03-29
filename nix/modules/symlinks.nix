{ config, ... }:
{
  # ---------------------------------------------------------------------------
  # Dotfile symlinks
  # Uses mkOutOfStoreSymlink so edits in ~/dot-files are reflected immediately
  # without requiring a rebuild.
  # ---------------------------------------------------------------------------
  home.file = {
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
    "ghostty".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/ghostty";
  };
}
