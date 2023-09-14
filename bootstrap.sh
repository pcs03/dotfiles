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
    read -p "Do you want to install desktop packages (e.g. firefox)? (Y/n) " choice
    if [[ $choice == [Yy] ]]; then 
        DESKTOP=true
    fi
fi

read -p "The detected Operating system is $OS, is this correct? (Y/n) " choice
if [[ $choice == [Nn] ]]; then
    echo "Exiting script..."
    exit
fi

case "$OS" in
    'Arch Linux')
        script_path="$HOME/.dotfiles/arch.sh"
        ;;
    'Ubuntu')
        script_path="$HOME/.dotfiles/ubuntu.sh"
        ;;
    'Raspbian GNU/Linux')
        script_path="$HOME/.dotfiles/rasbian.sh"
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
