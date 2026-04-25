#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

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
# 4. Language runtimes
# ---------------------------------------------------------------------------
header "Language runtimes"
bash "$SCRIPT_DIR/install-language-runtimes.sh"

# ---------------------------------------------------------------------------
# 5. Zsh plugins
# ---------------------------------------------------------------------------
header "Zsh plugins"
bash "$SCRIPT_DIR/install-zsh-plugins.sh"

# ---------------------------------------------------------------------------
# 6. Binary tools
# ---------------------------------------------------------------------------
header "Binary tools"
TOOLS_DIR="$DOTFILES_ROOT/tools"
mkdir -p "$TOOLS_DIR"

SLACK_TERM="$TOOLS_DIR/slack-term-darwin-amd64"
if [[ -f "$SLACK_TERM" ]]; then
  skip "slack-term already present"
else
  echo "  Downloading slack-term..."
  curl -fsSL -o "$SLACK_TERM" \
    https://github.com/jpbruinsslot/slack-term/releases/download/v0.5.0/slack-term-darwin-amd64
  chmod +x "$SLACK_TERM"
  ok "slack-term downloaded"
fi

# Expose tools dir on PATH (append to ~/.zshrc if not already present)
TOOLS_PATH_LINE="export PATH=\"$TOOLS_DIR:\$PATH\""
if grep -qF "$TOOLS_DIR" "$HOME/.zshrc" 2>/dev/null; then
  skip "tools PATH already in ~/.zshrc"
else
  echo "$TOOLS_PATH_LINE" >> "$HOME/.zshrc"
  ok "added tools to PATH in ~/.zshrc"
fi

echo
echo "All done."
