#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

link_entries=(
  ".bash_profile|$HOME/.bash_profile"
  ".bashrc|$HOME/.bashrc"
  ".fzf|$HOME/.fzf"
  ".gitmessage|$HOME/.gitmessage"
  ".hammerspoon|$HOME/.hammerspoon"
  ".homebrew|$HOME/.homebrew"
  ".mackup.cfg|$HOME/.mackup.cfg"
  ".tigrc|$HOME/.tigrc"
  ".tmux|$HOME/.tmux"
  ".tmux.conf|$HOME/.tmux.conf"
  ".vim|$HOME/.vim"
  ".vimrc|$HOME/.vimrc"
  ".vsvimrc|$HOME/.vsvimrc"
  ".xvimrc|$HOME/.xvimrc"
  ".zprofile|$HOME/.zprofile"
  ".zsh|$HOME/.zsh"
  ".zshrc|$HOME/.zshrc"
  ".zshrc_withoutp10k|$HOME/.zshrc_withoutp10k"
  "dircolors|$HOME/dircolors"
  "iterm2-color-schemes|$HOME/iterm2-color-schemes"
  "ohmyzsh|$HOME/ohmyzsh"
  "powerlevel10k|$HOME/powerlevel10k"
  "nvim|$HOME/.config/nvim"
  "wezterm|$HOME/.config/wezterm"
)

for entry in "${link_entries[@]}"; do
  source_rel="${entry%%|*}"
  target="${entry#*|}"
  source="$DOTFILES_ROOT/$source_rel"

  if [[ ! -e "$source" ]]; then
    echo "skip missing source: $source"
    continue
  fi

  mkdir -p "$(dirname "$target")"

  if ln -s "$source" "$target" 2> /dev/null; then
    echo "symlink src=$source to dst=$target..."
  else
    echo "symlink: '$target' exists"
  fi
done
