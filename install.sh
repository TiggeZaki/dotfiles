#!/bin/bash

# Core packages required at the system level
core_pkgs=(zsh vim git gnupg)
# Developer tools, often installed via user-level managers
devtools_pkgs=(sheldon starship eza fzf)
# Packages specific to the local host machine (non-container)
local_pkgs=(curl wget wl-clipboard)

install_apt() {
    sudo apt-get install -y --no-install-recommends "$@"
}

install_pacman() {
    sudo pacman -Syu --noconfirm --needed "$@"
}

safe_ln() {
  if [ ! -e "$2" ]; then
    ln -s "$1" "$2"
  fi
}

main() {
    source /etc/os-release
    if [ "$ID" = "arch" ]; then
        local pkgs=("${core_pkgs[@]}" "${devtools_pkgs[@]}")
        if [ "$REMOTE_CONTAINERS" != "true" ]; then
            pkgs+=("${local_pkgs[@]}")
        fi
        install_pacman "${pkgs[@]}"
    elif [ "$ID" = "debian" ]; then
        sudo apt update
        install_apt "${core_pkgs[@]}"
        install_brew "${devtools_pkgs[@]}"
        if [ "$is_dev_container" != "true" ]; then
            install_apt "${tools_pkgs[@]}"
        fi
    fi
    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then \
        USERPROFILE="/mnt/c/Users/"$(basename $HOME)
        safe_ln $USERPROFILE/Downloads $HOME/Downloads
        mkdir -p $HOME/.local/bin
        safe_ln "$USERPROFILE/Appdata/Local/Programs/Microsoft VS Code/bin/code" $HOME/.local/bin/code
    fi
}

main
