DESKTOP=false

while getopts d o; do
    case $o in
        (d) DESKTOP=true;;
    esac
done

echo "Synchronizing pacman..."
sudo pacman -Syu

echo "Installing base packages..."
sudo pacman -S --needed base-devel git bash-completion ethtool eza exfat-utils neofetch neovim nodejs npm ntfs-3g rsync vim docker yt-dlp

if [ $DESKTOP == true ]; then
    echo "Installing additional desktop packages..."
    sudo pacman -S --needed bluez bluez-utils firefox noto-fonts noto-fonts-cjk noto-fonts-extra steam sushi thunderbird virtualbox virtualbox-host-modules-arch obsidian qbittorrent
fi

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
yay -S --needed --noconfirm --nocleanmenu --nodiffmenu git-completion

if [ $DESKTOP == true ]; then
    echo "Installing additional desktop AUR packages..."
    yay -S --needed --noconfirm --nocleanmenu --nodiffmenu jdk17-temurin postman-bin proton-ge-custom-bin visual-studio-code-bin
fi

echo "Creating symlinks to custom dotfiles..."
cd ~/.dotfiles/dot

for dotfile in .*; do
	if [ -f "$dotfile" ]; then
		echo "Creating symlink for $dotfile"
		rm -f ~/"$dotfile"
		ln -s ~/.dotfiles/dot/"$dotfile" ~/"$dotfile"
  	fi
done

if [ -d "$HOME/.config/nvim" ]; then
	read -p "The nvim directory already exists, overwrite it? (Y/n): " choice
	if [[ $choice == [Nn] ]]; then
		echo "Skipping symlink for nvim directory"
	else
		echo "Removing old nvim directory..."
		rm -r "$HOME/.config/nvim"
		
		echo "Creating symlink for nvim directory..."
		ln -s "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
	fi
fi


echo "Enabling & Starting docker"
sudo systemctl enable docker
sudo systemctl start docker
