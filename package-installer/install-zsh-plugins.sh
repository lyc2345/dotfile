#!/bin/bash

set -euo pipefail

clone_if_missing() {
  local repo="$1"
  local dest="$2"
  if [ -d "$dest" ]; then
    echo "skip: $dest already exists"
  else
    git clone "$repo" "$dest"
  fi
}

ZSH_PLUGINS="${ZSH_CUSTOM:-${ZSH:-$HOME/ohmyzsh}/custom}/plugins"

# zsh-completions
clone_if_missing https://github.com/zsh-users/zsh-completions.git \
  "$ZSH_PLUGINS/zsh-completions"

# zsh-syntax-highlighting
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_PLUGINS/zsh-syntax-highlighting"

# zsh-autosuggestions
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_PLUGINS/zsh-autosuggestions"
