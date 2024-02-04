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

dotfiles=$(find "$HOME/.dotfiles/dot" -maxdepth 1 -mindepth 1 -type f -name '.*')

for dotfile in $dotfiles; do
    dotbase=$(basename "$dotfile")
    if [[ -f "$HOME/$dotbase" ]]; then
        echo -n "$dotbase already exists. "
    else
        echo -n "$dotbase does not exist. "
    fi

    read -p "Symlink $dotbase? (Y/n): " choice
    if [[ -z "$choice" ]] || [[ "$choice" == [yY] ]]; then
        if [[ -f "$HOME/$dotbase" ]]; then
            rm "$HOME/$dotbase"
            echo "  Removed existing $dotbase."
        fi

        ls -s "$HOME/.dotfiles/dot/$dotbase" "$HOME/$dotbase"
        echo "Created symlink for $dotbase"
    fi
done

configs=$(find "$HOME/.dotfiles/config/" -maxdepth 1 -mindepth 1 -type d)

for dir in $configs; do
    dirname=$(basename "$dir")
    if [[ -d "$HOME/.config/$dirname" ]]; then
        echo -n "$dirname directory already exists. "
    else
        echo -n "$dirname directory does not exist. "
    fi

    read -p "Symlink $dirname? (Y/n): " choice
    if [[ -z "$choice" ]] || [[ "$choice" == [Yy] ]]; then
        if [[ -d "$HOME/.config/$dirname" ]]; then
            rm -rf "$HOME/.config/$dirname"
            echo "  Removed existing $dirname directory."
        fi

        ln -sf "$HOME/.dotfiles/config/$dirname" "$HOME/.config/$dirname"
        echo "  Created symlink for $dirname directory."
        echo ""
    fi
done

case "$OS" in
    'Arch Linux')
        script_path="$HOME/.dotfiles/arch.sh"
        echo "Arch"
        ;;
    'Ubuntu')
        script_path="$HOME/.dotfiles/ubuntu.sh"
        echo "Ubuntu"
        ;;
    'Raspbian GNU/Linux')
        script_path="$HOME/.dotfiles/raspbian.sh"
        echo "Raspbian"
        ;;
    *)
        echo "OS not supported, exiting script..."
        exit
        ;;
esac
