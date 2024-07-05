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

dotfiles_dir="$HOME/.dotfiles/dot"

for dotfile in $(find "$dotfiles_dir" -type f); do
    relative_path="${dotfile#$dotfiles_dir/}"
    target="$HOME/$relative_path"
    
    if [[ -f "$target" ]]; then
        echo -n "$relative_path already exists. "
    else
        echo -n "$relative_path does not exist. "
    fi

    read -p "Symlink $relative_path? (Y/n): " choice
    if [[ -z "$choice" ]] || [[ "$choice" == [yY] ]]; then
        if [[ -f "$target" ]]; then
            rm "$target"
            echo "  Removed existing $relative_path."
        fi

        mkdir -p "$(dirname "$target")"

        ln -s "$dotfile" "$target"
        echo "  Created symlink for $relative_path"
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
