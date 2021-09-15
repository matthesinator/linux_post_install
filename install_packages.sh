#!/bin/bash

if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
    sudo apt-get install -y $(<./package_lists/basics)
    # sudo apt-get install -y $(<./package_lists/apt)

    # Install node, since apt versions are not current
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs

    if [ -x "$(command -v snap)" ]; then
	sudo snap install spotify
	sudo snap install --classic code
    else
	echo "Snap not installed, couldn't install Spotify and VSCode."
    fi

elif [ -x "$(command -v pacman)" ]; then
    sudo pacman -Syu --noconfirm
    sudo pacman -Qtdq | pacman -Rns - --noconfirm
    sudo pacman -S --noconfirm $(<./package_lists/basics)
    sudo pacman -S --noconfirm $(<./package_lists/pacman)

    # Setup AUR using yay
    sudo pacman -S --needed --noconfirm base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    yes | makepkg -si
    cd ..
    yes | rm -r yay

    # Get AUR packages
    yay -S --noconfirm spotify
    yay -S --noconfirm visual-studio-code-bin
else
    echo "Neither pacman nor apt-get found, skipping package installation."
fi

chsh -s /bin/zsh

echo
echo "Package lists installed. Default shell set to zsh."
echo "Current Node.js version is 14, which is LTS."
echo
echo "Type 'exit' after Oh My Zsh has opened"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

echo
echo "Oh My Zsh and plugins installed."
echo

read -p "Packages installed, press any key to continue." -n 1
echo
