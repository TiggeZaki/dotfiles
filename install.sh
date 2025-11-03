#!/bin/bash

system_pkgs=(zsh vim gpg)
dev_pkgs=(sheldon starship eza fzf)
tools_pkgs=(curl wget wl-clipboard)

install_apt() {
    sudo apt-get install -y --no-install-recommends "$@"
}

install_pacman() {
    sudo pacman -Syu --noconfirm --needed "$@"
}

main() {
    source /etc/os-release
    if [ "$ID" = "arch" ]; then
        local all_pkgs=("${system_pkgs[@]}" "${dev_pkgs[@]}" "${tools_pkgs[@]}")
        install_pacman "${all_pkgs[@]}"
    elif [ "$ID" = "debian" ]; then
        sudo apt update
        install_apt "${system_pkgs[@]}"
    fi
    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then \
        USERPROFILE="/mnt/c/Users/"$(basename $HOME)
        safe_ln $USERPROFILE/Downloads $HOME/Downloads
        mkdir -p $HOME/.local/bin
        safe_ln "$USERPROFILE/Appdata/Local/Programs/Microsoft VS Code/bin/code" $HOME/.local/bin/code
    fi
}

main
