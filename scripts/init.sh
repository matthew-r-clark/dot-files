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
    # Install nix-darwin
    if command -v darwin-rebuild &>/dev/null; then
        echo "Running darwin-rebuild switch..."
        sudo darwin-rebuild switch --flake ~/dot-files
    else
        echo "Bootstrapping nix-darwin (requires sudo)..."
        sudo nix --extra-experimental-features 'nix-command flakes' \
            run sudo nix-darwin -- switch --flake ~/dot-files
    fi

    # Install Homebrew if not present
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "Running brew bundle..."
    brew bundle --file ~/dot-files/Brewfile

elif [ "$OS" = "Linux" ]; then
    # Install home-manager
    if command -v home-manager &>/dev/null; then
        echo "Running home-manager switch..."
        home-manager switch --flake ~/dot-files
    else
        echo "Bootstrapping home-manager..."
        nix --extra-experimental-features 'nix-command flakes' \
            run home-manager -- switch --flake ~/dot-files
    fi

    # Install Ghostty
    if ! command -v ghostty &>/dev/null; then
        echo "Installing Ghostty..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi
