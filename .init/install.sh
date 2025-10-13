#!/bin/sh

# Install packages from list
sudo pacman -S --needed $(cat pkglist.txt)

USERPROFILE="/mnt/c/Users/$(basename $HOME)"
ln -s $USERPROFILE/Downloads $HOME/Downloads
mkdir -p $HOME/.local/bin
ln -s "$USERPROFILE/Appdata/Local/Programs/Microsoft VS Code/bin/code" $HOME/.local/bin/code
