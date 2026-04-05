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
        - Applies macOS system defaults automatically: dark mode, fast key repeat, natural scroll disabled, Dock autohide + 44px tiles, Finder gallery view
    - On **Linux**: bootstrap home-manager (installs all packages, manages dotfile symlinks)
    - Install sqlit (SQL TUI) with postgresql driver.

2. Install manually (not managed by nix):
    - **[Arc](https://arc.net/)** — browser (macOS only)
    - **[ChatGPT](https://openai.com/chatgpt/download/)** — AI assistant desktop app
    - **[Claude Desktop](https://claude.ai/download)** — AI assistant desktop app
    - **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** — container runtime
    - **[Firefox](https://www.mozilla.org/firefox/)** — browser
    - **[Google Chrome](https://www.google.com/chrome/)** — browser
    - GlobalProtect — VPN client (download link provided by IT) 
        * May need to explicitly install v6.2.2-259 if you have issues with mongo connections dropping.
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

4. Open neovim with `nvim` (not the `n` alias — that tries to restore a `Session.vim` which won't exist yet) and run `:Lazy restore` to install plugins pinned to `lua/lazy-lock.json`


## Common nix commands

```bash
nix-rebuild   # apply config changes without updating flake inputs
nix-update    # bump flake.lock to latest nixpkgs, then rebuild
nix-rollback  # roll back to previous generation (macOS); list generations (Linux)
nix-gc        # garbage collect old generations and free disk space (on-demand; auto-GC also runs every Sunday at 2am, pruning generations older than 30 days)
```

## Shell aliases

Defined in `nix/modules/zsh.nix` — includes shortcuts for Docker (`dc`, `dcu`, `dcd`, `dcl`), Neovim (`n`, `vw`), Git (`lzg`, `gstv`), and MicroPython/ampy (`py`, `pyg`, `pyp`, etc.).

## cli-tools

`~/dot-files/cli-tools/` is on `$PATH` automatically. Available commands: `op-get`, `op-create`, `op-edit`, `op-delete`, `git-reword-commit`, `git-replace-message`, `ireplace`, `replace`, `claude-auth`, `gen-git-prepare-commit-msg-hook`.

## Claude Code config

Claude Code settings, CLAUDE.md, custom commands, and skills are symlinked from `claude/` into `~/.claude/` via `nix/modules/symlinks.nix`. Edits to these files in `~/dot-files` take effect immediately — no `nix-rebuild` required.

## Adding a package

1. Add it to one of:
    - `nix/home-shared.nix` (cross-platform)
    - `nix/home-darwin.nix` (macOS-only)
    - `nix/home-linux.nix` (Linux-only)
2. Run the rebuild command above

## Scripts

- `scripts/init.sh` — new machine bootstrap (see Setup above)
- `scripts/vimwiki-backup.sh` — auto-commits and pushes `~/vimwiki`; intended to be run on a schedule (e.g., cron). Logs to `~/.vimwiki-auto-backup-log`.

## Nix tooling (linting, formatting)

```bash
nix develop    # enter dev shell with alejandra, statix, deadnix
nix fmt        # format all .nix files
```
