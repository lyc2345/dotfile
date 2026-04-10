#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DST="$HOME"

for f in "$DOTFILES_ROOT"/* "$DOTFILES_ROOT"/.[^.]*; do
    name="$(basename "$f")"

    if [[ "$name" == ".git" || "$name" == "install-scripts" || "$name" == "install-package-scripts" ]]; then
        continue
    fi

    if [[ "$name" == ".DS_Store" ]]; then
        continue
    fi

    target="$DST/$name"
    if unlink "$target" 2> /dev/null; then
        echo "unlink '$target'"
    else
        echo "unlink: '$target' not found"
    fi
done
