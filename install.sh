#!/bin/bash

if [ -d ~/.dotfiles ]; then
	echo "dotfiles directory is not empty, cancelling execution..."
	exit
fi
	
echo "Synchronizing pacman..."
sudo pacman -Syu

echo "Installing packages..."
sudo pacman -S --needed base-devel git bash-completion bluez bluez-utils ethtool exa exfat-utils firefox neofetch neovim nodejs npm noto-fonts noto-fonts-cjk noto-fonts-extra ntfs-3g obsidian qbittorrent rsync steam sushi thunderbird vim virtualbox virtualbox-host-modules-arch docker

echo "Cloning git dotfiles repository..."
git clone https://github.com/pcs03/dotfiles.git ~/.dotfiles

echo "Installing yay AUR helper..."
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

echo "Installing AUR packages..."
yay -S --needed --noconfirm --nocleanmenu --nodiffmenu git-completion jdk17-temurin postman-bin proton-ge-custom-bin visual-studio-code-bin

echo "Creating symlinks to custom dotfiles..."
cd ~/.dotfiles

for dotfile in .*; do
	if [ -f "$dotfile" ] && [ "$dotfile" != ".git" ]; then
		echo "Creating symlink for $dotfile"
		rm -f ~/"$dotfile"
		ln -s ~/.dotfiles/"$dotfile" ~/"$dotfile"


echo "Enabling & Starting docker"
sudo systemctl enable docker
sudo systemctl start docker