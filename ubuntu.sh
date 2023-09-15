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

if [ $DESKTOP == true ]; then
    echo "Installing additional desktop packages..."
    sudo apt install firefox steam qbittorrent
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

if command -v docker &>/dev/null; then
    echo "Docker is already installed."
else 
    read -p "Docker is not installed, do you want to install it? (Y/n)" choice
    if [[ $choice == [Nn] ]]; then
        echo "Exiting script..."
    else
        echo "Installing docker..."

        for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

        # Add Docker's official GPG key:
        sudo apt-get update
        sudo apt-get install ca-certificates curl gnupg
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg

        # Add the repository to Apt sources:
        echo \
        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update

        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    fi
fi
