# Dot Files

## Setup (new machine)

1. Clone dot-files repo
    ```bash
    git clone git@github.com:matthew-r-clark/dot-files.git ~/dot-files
    ~/dot-files/scripts/init.sh
    ```
2. Install Ghostty (terminal emulator)
    https://ghostty.org/download
3. Run init script
    `init.sh` will:
    a) Install Nix via the [Determinate Systems installer](https://github.com/DeterminateSystemsInitiative/nix-installer) if not already present.
        - On **macOS**: activate nix-darwin + home-manager, which installs all packages and manages dotfile symlinks.
            * Note: the first run requires sudo to bootstrap nix-darwin. Subsequent runs do not.
        - On **Linux**: activate home-manager, which installs all packages and manages dotfile symlinks.
    b) If **macOS**, installs brew.
    c) Install Ghostty terminal emulator.
        * Note: on **macOS**: installs cask via brew.

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

1. Add it to one of:
    - `nix/home-shared.nix` (cross-platform)
    - `nix/home-darwin.nix` (macOS-only)
    - `nix/home-linux.nix` (Linux-only)
2. Run one of:
    - `sudo darwin-rebuild switch --flake ~/dot-files` (macOS)
    - `home-manager switch --flake ~/dot-files` (Linux)

## Neovim

Open neovim and run `:Lazy restore` to install plugins pinned to `lua/lazy-lock.json`.
