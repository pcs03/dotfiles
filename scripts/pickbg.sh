#!/usr/bin/env bash

# Simple utility that picks a random file from a directory of wallpapers.

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Error: '$1' is not a vald directory."
    exit 1
fi

directory=$(realpath $1)

wallpaper=$(find "$directory" -type f | shuf -n 1)

echo $wallpaper
