#!/usr/bin/env bash
set -eu

install_nix() {
    if command -v nix >/dev/null 2>&1; then
        echo "Nix is already installed"
        return 0
    fi

    if ! command -v curl >/dev/null 2>&1; then
        echo "Error: curl is required to download the Nix installer. Please install curl and re-run." >&2
        return 1
    fi

    echo "Installing Nix (multi-user daemon mode)..."

    sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon --yes

    echo "Nix installer finished"

    # Try to source common profile scripts so `nix` becomes available in this shell.
    if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi

    if command -v nix >/dev/null 2>&1; then
        echo "Nix installed successfully"
        return 0
    else
        echo "Nix installation completed but 'nix' command not found in PATH. You may need to log out and log back in." >&2
        return 1
    fi
}

enable_flakes() {
    local desired="experimental-features = nix-command flakes"
    local user_conf="$HOME/.config/nix/nix.conf"

    # Only operate on per-user config. Do not touch /etc/nix/nix.conf.
    if grep -Eq 'experimental-features.*flakes' "$user_conf" 2>/dev/null; then
        echo "Nix flakes already enabled in $user_conf"
        return 0
    fi

    mkdir -p "$(dirname "$user_conf")"

    if [ -f "$user_conf" ] && grep -Eq '^experimental-features' "$user_conf"; then
        # Replace existing experimental-features line
        if ! sed -i.bak "s|^experimental-features.*|$desired|" "$user_conf"; then
            echo "Failed to update $user_conf" >&2
            return 1
        fi
    else
        # Append desired line
        if ! printf '%s\n' "$desired" >> "$user_conf"; then
            echo "Failed to write $user_conf" >&2
            return 1
        fi
    fi

    echo "Enabled flakes in $user_conf"
    return 0
}

install_packages() {
    local packages=(
        "zsh"
        "vim"
        "stow" # for managing dotfiles
        "gnupg" # for git commit signing
        "sheldon"
        "starship"
        "eza"
        "fzf"
        "wl-clipboard"
    )
    echo "Installing packages via nix profile..."
    for pkg in "${packages[@]}"; do
        nix profile add "nixpkgs#${pkg}"
    done
    stow -t $HOME home
    stow -t $HOME/.config config
}

main() {
    # 1) Install Nix
    if ! install_nix; then
        local rc=$?
        echo "install_nix failed with exit code ${rc}" >&2
        exit ${rc}
    fi

    # 2) Enable flakes in per-user config
    if ! enable_flakes; then
        rc=$?
        echo "enable_flakes failed with exit code ${rc}" >&2
        exit ${rc}
    fi

    # 3) Install packages via nix profile
    if ! install_packages; then
        rc=$?
        echo "install_packages failed with exit code ${rc}" >&2
        exit ${rc}
    fi
}

main "$@"