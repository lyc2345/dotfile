#!/bin/bash

set -euo pipefail

link_targets=(
  "$HOME/.bash_profile"
  "$HOME/.bashrc"
  "$HOME/.fzf"
  "$HOME/.gitmessage"
  "$HOME/.hammerspoon"
  "$HOME/.homebrew"
  "$HOME/.mackup.cfg"
  "$HOME/.tigrc"
  "$HOME/.tmux"
  "$HOME/.tmux.conf"
  "$HOME/.vim"
  "$HOME/.vimrc"
  "$HOME/.vsvimrc"
  "$HOME/.xvimrc"
  "$HOME/.zprofile"
  "$HOME/.zsh"
  "$HOME/.zshrc"
  "$HOME/.zshrc_withoutp10k"
  "$HOME/dircolors"
  "$HOME/iterm2-color-schemes"
  "$HOME/ohmyzsh"
  "$HOME/powerlevel10k"
  "$HOME/.config/nvim"
  "$HOME/.config/wezterm"
  "$HOME/.config/karabiner"
)

for target in "${link_targets[@]}"; do
  if [[ ! -L "$target" ]]; then
    echo "skip non-symlink: '$target'"
    continue
  fi

  if unlink "$target" 2> /dev/null; then
    echo "unlink '$target'"
  else
    echo "unlink: '$target' not found"
  fi
done
