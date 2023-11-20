#!/bin/bash

if [ -d ~/.dotfiles ]; then
	echo "dotfiles directory is not empty, what to do?"
    read -p $'[P]ull [O]verwrite [N]othing [E]xit\n$ ' choice
    if [[ $choice == [pP] ]]; then
        cd ~/.dotfiles
        git pull
    fi

    if [[ $choice == [oO] ]]; then
    	rm -rf ~/.dotfiles
    fi

    if [[ $choice == [eE] ]]; then
        exit
	fi
fi

if [ ! -d ~/.dotfiles ]; then
	git clone https://github.com/pcs03/dotfiles.git ~/.dotfiles
fi

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
fi


DESKTOP=false

if [[ ! $OS == 'Rasbian GNU/Linux' ]]; then
    read -p "Do you want to install desktop packages (e.g. firefox)? (y/N) " choice
    if [[ $choice == [Yy] ]]; then 
        DESKTOP=true
    fi
fi

read -p "The detected Operating system is $OS, is this correct? (Y/n) " choice
if [[ $choice == [Nn] ]]; then
    echo "Exiting script..."
    exit
fi

cd ~/.dotfiles/dot

dotfiles=$(find "$HOME/.dotfiles/dot" -maxdepth 1 -type f -name '.*')

for dotfile in $dotfiles; do
    dotbase=$(basename "$dotfile")
    if [ -f "$HOME/$dotbase" ]; then
        echo "Removing old file for $dotbase"
        rm -f "$HOME/$dotbase"
        echo "Creating symlink for $dotbase"
        ln -s "$dotfile" "$HOME/$dotbase"
    else
        echo "Creating symlink for $dotbase"
        ln -s "$dotfile" "$HOME/$dotbase"
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
else
    echo "Creating symlink for nvim directory..."
    ln -s "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
fi

if [ -d "$HOME/.config/tmux" ]; then
	read -p "The tmux directory already exists, overwrite it? (Y/n): " choice
	if [[ $choice == [Nn] ]]; then
		echo "Skipping symlink for tmux directory"
	else
		echo "Removing old tmux directory..."
		rm -r "$HOME/.config/tmux"
		
		echo "Creating symlink for tmux directory..."
		ln -s "$HOME/.dotfiles/tmux" "$HOME/.config/tmux"
	fi
else
    echo "Creating symlink for tmux directory..."
    ln -s "$HOME/.dotfiles/tmux" "$HOME/.config/tmux"
fi

case "$OS" in
    'Arch Linux')
        script_path="$HOME/.dotfiles/arch.sh"
        ;;
    'Ubuntu')
        script_path="$HOME/.dotfiles/ubuntu.sh"
        ;;
    'Raspbian GNU/Linux')
        script_path="$HOME/.dotfiles/raspbian.sh"
        ;;
    *)
        echo "OS not supported, exiting script..."
        exit
        ;;
esac

if [ $DESKTOP = true ]; then
    script_path="$script_path -d"
fi

bash $script_path
