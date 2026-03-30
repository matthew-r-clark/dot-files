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
    - **[1Password](https://1password.com/downloads/)** — password manager
    - **[Arc](https://arc.net/)** — browser (macOS only)
    - **[ChatGPT](https://openai.com/chatgpt/download/)** — AI assistant desktop app
    - **[Claude Desktop](https://claude.ai/download)** — AI assistant desktop app
    - **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** — container runtime
    - **[Firefox](https://www.mozilla.org/firefox/)** — browser
    - **[Google Chrome](https://www.google.com/chrome/)** — browser
    - GlobalProtect — VPN client (download link provided by IT)
    - **[Logi Options+](https://www.logitech.com/en-us/software/logi-options-plus.html)** — Logitech device manager
    - **[MongoDB Compass](https://www.mongodb.com/try/download/compass)** — GUI for MongoDB
    - **[OBSBOT Center](https://www.obsbot.com/download)** — webcam control app
    - **[Postman](https://www.postman.com/downloads/)** — API client
    - **[reMarkable](https://my.remarkable.com/device/apps)** — desktop companion for reMarkable tablet
    - **[Slack](https://slack.com/downloads/)** — team messaging
    - **[TOZO](https://apps.apple.com/us/app/tozo-tech-around-you/id1579260977)** — earbuds companion app
    - **[Zoom](https://zoom.us/download)** — video conferencing

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
