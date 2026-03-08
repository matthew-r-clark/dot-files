# Dot Files

## Setup (new machine)

```bash
git clone git@github.com:matthew-r-clark/dot-files.git ~/dot-files
~/dot-files/scripts/init.sh
```

`init.sh` will:
1. Install Nix via the [Determinate Systems installer](https://github.com/DeterminateSystemsInitiative/nix-installer) if not already present
2. On **macOS**: activate nix-darwin + home-manager, which installs all packages and manages dotfile symlinks
3. On **Linux**: activate home-manager, which installs all packages and manages dotfile symlinks

> **macOS note:** the first run requires sudo to bootstrap nix-darwin. Subsequent runs do not.

## Updating packages

```bash
nix flake update                              # bump flake.lock to latest nixpkgs
darwin-rebuild switch --flake ~/dot-files     # macOS
home-manager switch --flake ~/dot-files       # Linux
```

## Applying config changes (no version bump)

```bash
darwin-rebuild switch --flake ~/dot-files     # macOS
home-manager switch --flake ~/dot-files       # Linux
```

## Rolling back

```bash
darwin-rebuild --rollback     # macOS
home-manager generations      # Linux — lists generations to roll back to
```

## Adding a package

1. Add it to `nix/home-shared.nix` (cross-platform) or `nix/home-darwin.nix` (macOS-only)
2. Run `darwin-rebuild switch --flake ~/dot-files`

## Neovim

Open neovim and run `:Lazy restore` to install plugins pinned to `lua/lazy-lock.json`.
