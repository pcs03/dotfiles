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

cd ~/.dotfiles

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
