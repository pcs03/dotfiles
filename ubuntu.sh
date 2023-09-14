DESKTOP=false

while getopts d o; do
    case $o in
        (d) DESKTOP=true;;
    esac
done

echo 'Updating and Upgrading apt...'
sudo apt update
sudo apt upgrade

echo 'Installing base packages...'
sudo apt install build-essential git bash-completion ethtool exa exfat-utils neofetch neovim nodejs npm ntfs-3g rsync vim

if [ $DESKTOP == true ]; then
    echo "Installing additional desktop packages..."
    sudo apt install firefox steam qbittorrent
if

echo "Creating symlinks to custom dotfiles..."
cd ~/.dotfiles

for dotfile in .*; do
	if [ -f "$dotfile" ] && [ "$dotfile" != ".git" ]; then
		echo "Creating symlink for $dotfile"
		rm -f ~/"$dotfile"
		ln -s ~/.dotfiles/"$dotfile" ~/"$dotfile"
  	fi
done

if command -v docker &>/dev/null; then
    echo "Docker is already installed."
else 
    read -p "Docker is not installed, do you want to install it? (Y/n)" choice
    if [[ $choice == [Nn] ]]; then
        echo "Exiting script..."
    else
        echo "Installing docker..."
    fi
fi

