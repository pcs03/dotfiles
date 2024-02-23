cd "$HOME/.dotfiles"
source "./ubuntu/packages.sh"

echo 'Updating and upgrading apt.'
sudo apt update
sudo apt upgrade
echo 'apt updated.'

echo 'Installing base packages...'
sudo apt install build-essential git bash-completion ethtool exa neofetch neovim nodejs npm ntfs-3g rsync vim

# Wake on LAN or smth too lazy rn

echo "Updating base packages."
for pack in ${base[@]}; do
    sudo apt install -y $pack
done

read -p "Update desktop packages? (y/N): " choice
if [[ $choice == [yY] ]]; then
    for pack in ${desktop[@]}; do
        sudo apt install -y $pack
    done
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
