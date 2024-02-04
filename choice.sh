#!/bin/bash

while true; do
    echo "Choose a DE/WM to install:"
    echo "1. GNOME"
    echo "2. Hyprland"

    read -p "Enter the number of your choice: " choice

    case $choice in
        1)
            DE="gnome"
            # Add your installation command for Package Choice 1 here
            break
            ;;
        2)
            DE="hypr"
            # Add your installation command for Package Choice 2 here
            break
            ;;
        *)
            echo "Invalid choice. Please enter 1 or 2."
            ;;
    esac
done

