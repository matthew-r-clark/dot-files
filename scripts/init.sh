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
    # install nix
    if command -v darwin-rebuild &>/dev/null; then
        echo "Running darwin-rebuild switch..."
        darwin-rebuild switch --flake ~/dot-files
    else
        echo "Bootstrapping nix-darwin (requires sudo)..."
        sudo nix --extra-experimental-features 'nix-command flakes' \
            run nix-darwin -- switch --flake ~/dot-files
    fi

    # install ghostty
    if [ ! -d "/Applications/Ghostty.app" ]; then
        curl -L -o /tmp/ghostty.dmg "https://release.files.ghostty.org/1.3.1/Ghostty.dmg"
        hdiutil attach /tmp/ghostty.dmg -nobrowse -quiet
        cp -R /Volumes/Ghostty/App.app /Applications/
        hdiutil detach /Volumes/Ghostty -quiet
        rm /tmp/ghostty.dmg
    fi

elif [ "$OS" = "Linux" ]; then
    # install nix
    if command -v home-manager &>/dev/null; then
        echo "Running home-manager switch..."
        home-manager switch --flake ~/dot-files
    else
        echo "Bootstrapping home-manager..."
        nix --extra-experimental-features 'nix-command flakes' \
            run home-manager -- switch --flake ~/dot-files
    fi

    # install ghostty
    if ! command -v ghostty &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi
