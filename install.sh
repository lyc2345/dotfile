#!/bin/bash

DST="$HOME"

for f in * .[^.]*; do

    # Don't copy install, uninstall shellscripts
    if [[ $f == *"install.sh"* ]]; then
        continue
    fi

    # Skip .DS_Store
    if [[ $f == *".DS_Store"* ]]; then
        continue
    fi

    target="$DST/$(basename "$f")"
    file="$(readlink -f $f)"

    ln -s $file $DST 2> /dev/null

    if [ $? -eq 0 ]; then
        echo "symlink src=$file to dst=$target..."
    else
        echo "symlink: '$target' exists"
    fi

    .fzf/install
done
