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
cd ~/.dotfiles

for dotfile in .*; do
	if [ -f "$dotfile" ] && [ "$dotfile" != ".git" ]; then
		echo "Creating symlink for $dotfile"
		rm -f ~/"$dotfile"
		ln -s ~/.dotfiles/"$dotfile" ~/"$dotfile"
  	fi
done

if [ -f "$HOME/.config/nvim/init.lua" ]; then
    rm "$HOME/.config/nvim/init.lua"
    echo 'Creating symlink for nvim init.lua'
    ln -s ./nvim/init.lua "$HOME/.config/nvim/init.lua"
elif [ -d "$HOME/.config/nvim" ]; then
    echo 'Creating symlink for nvim init.lua'
    ln -s ./nvim/init.lua "$HOME/.config/nvim/init.lua"
else
    mkdir "$HOME/.config/nvim"
    echo 'Creating symlink for nvim init.lua'
    ln -s ./nvim/init.lua "$HOME/.config/nvim/init.lua"
fi


echo "Enabling & Starting docker"
sudo systemctl enable docker
sudo systemctl start docker
