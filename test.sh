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


