#!/bin/bash

[[ ! "$(pwd)" =~ linux_post_install$ ]] && echo "Run from linux_post_install folder." && exit

clear
echo "Installing packages..."
./install_packages.sh

clear
echo "Choose source of dotfiles (.vimrc, .zshrc) or skip."
echo "0) Skip"
echo "1) Copy from this repo"
echo "2) Symlink to shared /home"
read -p "> " -n 1
echo

if [ "$REPLY" -eq 1 ]; then
    yes | cp ./dots/.vimrc "/home/${USER}/.vimrc"
    yes | cp ./dots/.zshrc "/home/${USER}/.zshrc"
elif [ "$REPLY" -eq 2 ]; then
    ./create_symlinks.sh .vimrc .zshrc
fi
#TODO: source ~/.zshrc?

clear
read -p "Symlink personal /home folders (Documents, Downloads, ...)? [y/n] " -n 1
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./create_symlinks.sh Documents Downloads Music Pictures Videos workspaces
fi

clear
