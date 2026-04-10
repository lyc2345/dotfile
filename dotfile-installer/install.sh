#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DST="$HOME"

for f in "$DOTFILES_ROOT"/* "$DOTFILES_ROOT"/.[^.]*; do
    name="$(basename "$f")"

    # Keep repository internals and install helpers out of $HOME.
    if [[ "$name" == ".git" || "$name" == "install-scripts" || "$name" == "install-package-scripts" ]]; then
        continue
    fi

    if [[ "$name" == ".DS_Store" ]]; then
        continue
    fi

    target="$DST/$name"
    file="$(cd "$(dirname "$f")" && pwd -P)/$(basename "$f")"

    if ln -s "$file" "$target" 2> /dev/null; then
        echo "symlink src=$file to dst=$target..."
    else
        echo "symlink: '$target' exists"
    fi
done
