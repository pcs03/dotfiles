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
sudo apt install build-essential git bash-completion ethtool exa neofetch neovim nodejs npm ntfs-3g rsync vim

echo "Creating symlinks to custom dotfiles..."
cd ~/.dotfiles

for dotfile in .*; do
	if [ -f "$dotfile" ] && [ "$dotfile" != ".git" ]; then
		echo "Creating symlink for $dotfile"
		rm -f ~/"$dotfile"
		ln -s ~/.dotfiles/"$dotfile" ~/"$dotfile"
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

if command -v docker &>/dev/null; then
    echo "Docker is already installed."
else 
    read -p "Docker is not installed, do you want to install it? (Y/n)" choice
    if [[ $choice == [Nn] ]]; then
        echo "Exiting script..."
    else
        echo "Docker installation not implemented yet."
    fi
fi
