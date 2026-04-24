#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Install it from https://brew.sh first."
  exit 1
fi

echo "Running brew bundle with $BREWFILE ..."
brew bundle install --file="$BREWFILE"
echo "Done."
