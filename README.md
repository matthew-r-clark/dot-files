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
    * Note: Added to nix but not tested yet so verify they're installed and working properly before attempting to install manually:
        - **[1Password GUI](https://1password.com/downloads/)** — password manager
        - **[1Password CLI](https://app-updates.agilebits.com/product_history/CLI2)**

3. Configure 1Password GUI to connect with CLI
    * Even with nix installation you will need to: Go to `Settings → Developer` and enable "Connect with 1Password CLI

4. Open neovim and run `:Lazy restore` to install plugins pinned to `lua/lazy-lock.json`


## Common nix commands

```bash
nix-rebuild   # apply config changes without updating flake inputs
nix-update    # bump flake.lock to latest nixpkgs, then rebuild
nix-rollback  # roll back to previous generation (macOS); list generations (Linux)
nix-gc        # garbage collect old generations and free disk space
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
