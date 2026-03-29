# Dot Files

## Setup (new machine)

1. Clone dot-files repo and run init script
    ```bash
    git clone git@github.com:matthew-r-clark/dot-files.git ~/dot-files
    ~/dot-files/scripts/init.sh
    ```
    `init.sh` will:
    - Install Nix via the [Determinate Systems installer](https://github.com/DeterminateSystemsInitiative/nix-installer) if not already present
    - On **macOS**: bootstrap nix-darwin + home-manager (installs all packages, manages dotfile symlinks). First run requires sudo.
    - On **Linux**: bootstrap home-manager (installs all packages, manages dotfile symlinks)

2. Install manually (not managed by nix):
    - **[Ghostty](https://ghostty.org/download)** — terminal emulator (macOS: nix installs it automatically; Linux: download manually)
    - **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** — container runtime

3. Open neovim and run `:Lazy restore` to install plugins pinned to `lua/lazy-lock.json`

## Updating packages

```bash
nix-update    # alias: flake update + rebuild in one step

# or manually:
nix flake update                                        # bump flake.lock to latest nixpkgs
sudo darwin-rebuild switch --flake ~/dot-files          # macOS
home-manager switch --flake ~/dot-files                 # Linux
```

## Applying config changes (no version bump)

```bash
sudo darwin-rebuild switch --flake ~/dot-files     # macOS
home-manager switch --flake ~/dot-files            # Linux
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
2. Run the rebuild command above

## Nix tooling (linting, formatting)

```bash
nix develop    # enter dev shell with alejandra, statix, deadnix
nix fmt        # format all .nix files
```
