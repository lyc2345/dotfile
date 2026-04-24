#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG_DIR="$HOME/.config"
LEGACY_CONFIG_LINK="$DOTFILES_ROOT/.config"

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
  "karabiner|$HOME/.config/karabiner"
)

ensure_config_dir() {
  if [[ -L "$CONFIG_DIR" ]]; then
    local target
    target="$(readlink "$CONFIG_DIR")"

    if [[ "$target" == "$LEGACY_CONFIG_LINK" ]]; then
      unlink "$CONFIG_DIR"
      mkdir -p "$CONFIG_DIR"
      echo "replaced legacy ~/.config symlink with real directory"
      return
    fi

    echo "skip replacing linked ~/.config: $CONFIG_DIR -> $target"
    return
  fi

  if [[ -e "$CONFIG_DIR" && ! -d "$CONFIG_DIR" ]]; then
    echo "skip invalid ~/.config target: $CONFIG_DIR exists but is not a directory"
    return
  fi

  mkdir -p "$CONFIG_DIR"
}

ensure_config_dir

for entry in "${link_entries[@]}"; do
  source_rel="${entry%%|*}"
  target="${entry#*|}"
  source="$DOTFILES_ROOT/$source_rel"

  if [[ ! -e "$source" ]]; then
    echo "skip missing source: $source"
    continue
  fi

  # Guard against circular symlinks caused by $HOME pointing inside DOTFILES_ROOT
  if [[ "$target" == "$DOTFILES_ROOT"* ]]; then
    echo "skip dangerous target inside dotfiles root: $target"
    continue
  fi

  # Guard against placing symlink inside an existing real directory
  if [[ -d "$target" && ! -L "$target" ]]; then
    echo "skip real directory (remove manually first): $target"
    continue
  fi

  # Guard against re-running over an existing symlink — ln -s would silently
  # place a new symlink inside the symlinked directory instead of failing
  if [[ -L "$target" ]]; then
    echo "symlink: '$target' exists"
    continue
  fi

  mkdir -p "$(dirname "$target")"

  if ln -s "$source" "$target" 2> /dev/null; then
    echo "symlink src=$source to dst=$target..."
  else
    echo "symlink: '$target' exists"
  fi
done
