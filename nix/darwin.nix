{ pkgs, ... }:
{
  imports = [
    ./modules/macos-defaults.nix
  ];

  # Match the existing nixbld GID from the Determinate Systems Nix installer
  ids.gids.nixbld = 350;

  # Allow unfree packages (e.g. 1Password)
  nixpkgs.config.allowUnfree = true;

  # Enable flakes and new CLI
  nix.settings.experimental-features = "nix-command flakes";

  # Deduplicate identical files in the store via hardlinks
  nix.settings.auto-optimise-store = true;

  # Periodic garbage collection to prevent /nix/store bloat
  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 2; Minute = 0; }; # Sunday 2am
    options = "--delete-older-than 30d";
  };

  # Required for user-scoped system.defaults (Dock, Finder, NSGlobalDomain, etc.)
  system.primaryUser = "matthew.clark";

  # Declare the user so home-manager can infer home.homeDirectory
  users.users."matthew.clark" = {
    home = "/Users/matthew.clark";
  };

  # macOS system state version — do not change after first activation
  system.stateVersion = 4;
}
