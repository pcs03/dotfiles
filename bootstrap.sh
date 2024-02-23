#!/bin/bash

if [ -d "$HOME/.dotfiles" ]; then
	echo "dotfiles directory is not empty, what to do?"
    read -p $'[P]ull [O]verwrite [N]othing [E]xit\n$ ' choice
    if [[ $choice == [pP] ]]; then
        cd "$HOME/.dotfiles"
        git pull
    fi

    if [[ $choice == [oO] ]]; then
    	rm -rf "$HOME/.dotfiles"
    fi

    if [[ $choice == [eE] ]]; then
        exit
	fi
fi

if [ ! -d "$HOME/.dotfiles" ]; then
	git clone "https://github.com/pcs03/dotfiles.git" "$HOME/.dotfiles"
fi

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
fi

for dotfile in $(ls -A "$HOME/.dotfiles/dot"); do
    if [[ -f "$HOME/$dotfile" ]]; then
        echo -n "$dotfile already exists. "
    else
        echo -n "$dotfile does not exist. "
    fi

    read -p "Symlink $dotfile? (Y/n): " choice
    if [[ -z "$choice" ]] || [[ "$choice" == [yY] ]]; then
        if [[ -f "$HOME/$dotfile" ]]; then
            rm "$HOME/$dotfile"
            echo "  Removed existing $dotfile."
        fi

        ln -s "$HOME/.dotfiles/dot/$dotfile" "$HOME/$dotfile"
        echo "  Created symlink for $dotfile"
        echo ""
    fi
done

for config in $(ls -A "$HOME/.dotfiles/config"); do
    if [[ -d "$HOME/.config/$config" ]]; then
        echo -n "$config directory already exists. "
    else
        echo -n "$config directory does not exist. "
    fi

    read -p "Symlink $config? (Y/n): " choice
    if [[ -z "$choice" ]] || [[ "$choice" == [Yy] ]]; then
        if [[ -d "$HOME/.config/$config" ]]; then
            rm -rf "$HOME/.config/$config"
            echo "  Removed existing $config directory."
        fi

        ln -sf "$HOME/.dotfiles/config/$config" "$HOME/.config/$config"
        echo "  Created symlink for $config directory."
        echo ""
    fi
done

echo "All dotfiles are synchronized."
read -p "Do a full install? (y/N)" install

case "$OS" in
    'Arch Linux')
        /bin/bash "$HOME/.dotfiles/arch/update.sh"
        ;;
    'Ubuntu')
        /bin/bash "$HOME/.dotfiles/ubuntu/update.sh"
        ;;
    # 'Raspbian GNU/Linux')
    #     /bin/bash "$HOME/.dotfiles/raspbian/update.sh"
    #     ;;
    *)
        echo "OS not supported, exiting script..."
        exit
        ;;
esac
