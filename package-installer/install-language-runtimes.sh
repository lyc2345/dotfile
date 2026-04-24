#!/bin/bash

set -euo pipefail

ok()   { echo "  ok: $*"; }
skip() { echo "  skip: $*"; }
info() { echo "  $*"; }

# Python — latest stable 3.x via pyenv
if command -v pyenv &>/dev/null; then
  PYTHON_VERSION=$(pyenv install --list 2>/dev/null \
    | grep -E '^\s+3\.[0-9]+\.[0-9]+$' \
    | tail -1 | tr -d ' ')
  info "Python latest stable: $PYTHON_VERSION"
  pyenv install --skip-existing "$PYTHON_VERSION"
  pyenv global "$PYTHON_VERSION"
  ok "Python $PYTHON_VERSION set as global"
else
  skip "pyenv not found"
fi

# Node — latest LTS via fnm
if command -v fnm &>/dev/null; then
  fnm install --lts
  fnm default lts-latest
  ok "Node LTS installed and set as default"
else
  skip "fnm not found"
fi

# Ruby — latest stable via rbenv
if command -v rbenv &>/dev/null; then
  RUBY_VERSION=$(rbenv install --list 2>/dev/null \
    | grep -E '^\s+[0-9]+\.[0-9]+\.[0-9]+$' \
    | tail -1 | tr -d ' ')
  info "Ruby latest stable: $RUBY_VERSION"
  rbenv install --skip-existing "$RUBY_VERSION"
  rbenv global "$RUBY_VERSION"
  ok "Ruby $RUBY_VERSION set as global"
else
  skip "rbenv not found"
fi
