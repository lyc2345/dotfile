#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BREWFILE="$DOTFILES_ROOT/dotfile-installer/Brewfile"

header() { echo; echo "==> $*"; }
skip()   { echo "  skip: $*"; }
ok()     { echo "  ok: $*"; }

# ---------------------------------------------------------------------------
# 1. Git submodules
# ---------------------------------------------------------------------------
header "Git submodules"
if [[ -f "$DOTFILES_ROOT/.gitmodules" ]]; then
  git -C "$DOTFILES_ROOT" submodule update --init --recursive
  ok "submodules up to date"
else
  skip "no .gitmodules found"
fi

# ---------------------------------------------------------------------------
# 2. Homebrew
# ---------------------------------------------------------------------------
header "Homebrew"
if command -v brew &>/dev/null; then
  skip "Homebrew already installed ($(brew --version | head -1))"
else
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ok "Homebrew installed"
fi

# ---------------------------------------------------------------------------
# 3. Homebrew packages (Brewfile)
# ---------------------------------------------------------------------------
header "Homebrew packages"
if [[ ! -f "$BREWFILE" ]]; then
  skip "Brewfile not found at $BREWFILE"
else
  brew bundle install --file="$BREWFILE"
  ok "brew bundle done"
fi

# ---------------------------------------------------------------------------
# 4. Zsh plugins
# ---------------------------------------------------------------------------
header "Zsh plugins"
bash "$SCRIPT_DIR/install-zsh-plugins.sh"

echo
echo "All done."
