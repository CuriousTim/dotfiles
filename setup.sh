#!/bin/sh


# This script must be executed from its directory.
PWD="$(pwd)"

# symlink all dotfiles into home directory
for file in .[a-z]*
do
    if [ -f "$file" ]
    then
        ln -s -f "${PWD}/${file}" "${HOME}/${file}"
    fi
done

cp -fas "${PWD}/.config/" "$HOME"

rsync --delete --dirs wallpapers "$HOME"
