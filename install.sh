#!/bin/bash

sudo pacman -Syu
sudo pacman -S base-devel git 

git clone https://github.com/pcs03/dotfiles.git ~/.dotfiles

sudo pacman -S --needed - < ~/.dotfiles/pacman.txt

if command -v yay &>/dev/null; then
	echo "yay is already installed."
else
	echo 'yay is not installed on this system.'
	
	read -p "Do you want to install yay? (y/n): " choice
	if [[ $choice == [yY] ]]; then
		mkdir /tmp/yay
		cd /tmp/yay
		curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
		makepkg -si
		cd ~/.dotfiles/ 
		rm -rf /tmp/yay
		yay --version
		echo "yay has been installed."
	else
		echo "Skipping yay installation."
	fi
fi

yay -S --needed --noconfirm --nocleanmenu --nodiffmenu - < ~/.dotfiles/yay.txt

ln -s ~/.dotfiles/.bashrc ~/.bashrc 
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

