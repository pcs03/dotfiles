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


DE_NAME=$(echo $XDG_CURRENT_DESKTOP)
case $DE_NAME in
    "GNOME")
        DE=1
        DE_PACKS=$gnome
        ;;
    "Hyprland")
        DE=2
        DE_PACKS=$hypr
        ;;
    *)
        echo "No supported DE/WM: $DE_NAME"
        exit
        ;;
esac

echo "Updating base packages."
for pack in ${base[@]}; do
    if ! { yay -Q $pack > /dev/null 2>&1 || yay -Qg $pack > /dev/null 2>&1; }; then
        yay -S --needed --cleanmenu=false --diffmenu=false $pack
    fi
done

# Installation of additional packages
read -p "Update desktop packages? (Y/n): " choice
if [[ -z $choice ]] || [[ $choice == [yY] ]]; then
    echo "Updating desktop packages."
    for pack in ${desktop[@]}; do
    if ! { yay -Q $pack > /dev/null 2>&1 || yay -Qg $pack > /dev/null 2>&1; }; then
        yay -S --needed --cleanmenu=false --diffmenu=false $pack
    fi
    done

    for pack in ${DE_PACKS[@]}; do
    if ! { yay -Q $pack > /dev/null 2>&1 || yay -Qg $pack > /dev/null 2>&1; }; then
        yay -S --needed --cleanmenu=false --diffmenu=false $pack
    fi
    done
fi

echo "Enabling & Starting docker"
sudo systemctl enable docker
sudo systemctl start docker
