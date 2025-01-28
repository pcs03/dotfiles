cd "$HOME/.dotfiles"
source "./arch/packages.sh"

# Check for yay
if [ ! -f /sbin/yay ]; then  
    echo "Installing yay."
    mkdir /tmp/yay
    cd /tmp/yay
    curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
    makepkg -si
    cd ~/.dotfiles/ 
    rm -rf /tmp/yay
    echo "yay installed."
    if [ ! -f /sbin/yay ]; then
        # if this is hit then a package is missing, exit to review log
        echo"yay install failed."
        exit
    fi
fi

# update the yay database
echo "Updating yay."
yay -Syu --noconfirm
echo "yay updated."

# Additional configurations
read -p "Enter network interface for Wake on LAN (leave blank if not desired): " interface
if [ ! -z $interface ]; then
    mac=$(ip link show "$interface" | grep link/ether | awk '{print $2}')
    if [ ! -z $mac ]; then
        echo "[Match]
MACAddress=$mac

[Link]
NamePolicy=kernel database onboard slot path
MACAddressPolicy=persistent
WakeOnLan=magic" | sudo tee /etc/systemd/network/50-wired.link > /dev/null
        
        echo "Created Wake on LAN configuration file"
    else
        echo "Could not find MAC address for interface, Wake on LAN will not be enabled."
    fi
fi

echo "Updating base packages."
for pack in ${base[@]}; do
    if ! { yay -Q $pack > /dev/null 2>&1 || yay -Qg $pack > /dev/null 2>&1; }; then
        yay -S --needed --cleanmenu=false --diffmenu=false $pack
    fi
done

# Installation of additional packages
read -p "Update base desktop packages? (Y/n): " choice
if [[ -z $choice ]] || [[ $choice == [yY] ]]; then
    echo "Updating desktop packages."
    for pack in ${desktop[@]}; do
        if ! { yay -Q $pack > /dev/null 2>&1 || yay -Qg $pack > /dev/null 2>&1; }; then
            yay -S --needed --cleanmenu=false --diffmenu=false $pack
        fi
    done

    read -p "Update packages for GNOME? (y/N): " choice
    if [[ $choice == [Yy] ]]; then
        for pack in ${gnome[@]}; do
            if ! { yay -Q $pack > /dev/null 2>&1 || yay -Qg $pack > /dev/null 2>&1; }; then
                yay -S --needed --cleanmenu=false --diffmenu=false $pack
            fi
        done
    fi

    read -p "Update packages for Hyprland? (y/N): " choice
    if [[ $choice == [Yy] ]]; then
        for pack in ${hypr[@]}; do
            if ! { yay -Q $pack > /dev/null 2>&1 || yay -Qg $pack > /dev/null 2>&1; }; then
                yay -S --needed --cleanmenu=false --diffmenu=false $pack
            fi
        done
    fi
fi

echo "Enabling & Starting docker"
sudo systemctl enable docker
sudo systemctl start docker

# Install yay
# Update repositorise w yay
# Enable wake on LAN
# Install base packages
# Install desktop packages (optional)
# Install hyprland packages (optional)
