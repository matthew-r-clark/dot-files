#!/bin/bash
set -e

OS=$(uname -s)

# Install Nix if not present
if ! command -v nix &>/dev/null; then
    echo "Installing Nix..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
        sh -s -- install --no-confirm

    # Make nix available in the current session
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        # shellcheck source=/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
fi

if [ "$OS" = "Darwin" ]; then
    if command -v darwin-rebuild &>/dev/null; then
        echo "Running darwin-rebuild switch..."
        darwin-rebuild switch --flake ~/dot-files
    else
        echo "Bootstrapping nix-darwin (requires sudo)..."
        sudo nix --extra-experimental-features 'nix-command flakes' \
            run nix-darwin -- switch --flake ~/dot-files
    fi
elif [ "$OS" = "Linux" ]; then
    if command -v home-manager &>/dev/null; then
        echo "Running home-manager switch..."
        home-manager switch --flake ~/dot-files
    else
        echo "Bootstrapping home-manager..."
        nix --extra-experimental-features 'nix-command flakes' \
            run home-manager -- switch --flake ~/dot-files
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi
