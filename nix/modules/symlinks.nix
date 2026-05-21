{ config, lib, ... }:
{
  # ---------------------------------------------------------------------------
  # Dotfile symlinks
  # Uses mkOutOfStoreSymlink so edits in ~/dot-files are reflected immediately
  # without requiring a rebuild.
  # ---------------------------------------------------------------------------
  home.file = {
    ".pspgconf".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/postgres/.pspgconf";

    ".psqlrc".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/postgres/.psqlrc";


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

    "alacritty".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/alacritty";

    "lazyclaude/config.json".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/lazyclaude/config.json";

    "npm/secrets.env".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dot-files/npm/secrets.env";

  };

  home.activation = {
    # colima.yaml is the user-facing Colima config. Uses activation rather than
    # home.file because ~/.colima/default/ may not exist before first colima start.
    colimaConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "$HOME/.colima/default"
      ln -sf "$HOME/dot-files/docker/colima.yaml" "$HOME/.colima/default/colima.yaml"
    '';

    # Repair the Docker socket symlink chain so Testcontainers and Ryuk find
    # the Colima socket via the standard /var/run/docker.sock path.
    # /var/run/docker.sock -> ~/.docker/run/docker.sock -> ~/.colima/default/docker.sock
    dockerRunSocket = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "$HOME/.docker/run"
      ln -sf "$HOME/.colima/default/docker.sock" "$HOME/.docker/run/docker.sock"
    '';

  };
}
