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

if [ -f "$HOME/.config/nvim/init.lua" ]; then
    rm "$HOME/.config/nvim/init.lua"
    mv ./nvim/init.lua "$HOME/.config/nvim/"
elif [ -d "$HOME/.config/nvim" ]; then
    mv ./nvim/init.lua "$HOME/.config/nvim/"
else
    mkdir "$HOME/.config/nvim"
    mv ./nvim/init.lua "$HOME/.config/nvim/"
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
