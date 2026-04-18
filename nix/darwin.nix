{ pkgs, ... }:
{
  imports = [
    ./modules/macos-defaults.nix
  ];

  # Determinate Nix manages its own daemon — disable nix-darwin's Nix management
  # to avoid conflicts. GC, store optimization, and flakes are handled by Determinate.
  nix.enable = false;

  # Match the existing nixbld GID from the Determinate Systems Nix installer
  ids.gids.nixbld = 350;

  # Allow unfree packages (e.g. 1Password)
  nixpkgs.config.allowUnfree = true;

  # Required for user-scoped system.defaults (Dock, Finder, NSGlobalDomain, etc.)
  system.primaryUser = "matthew.clark";

  # Declare the user so home-manager can infer home.homeDirectory
  users.users."matthew.clark" = {
    home = "/Users/matthew.clark";
  };

  # macOS system state version — do not change after first activation
  system.stateVersion = 4;
}
