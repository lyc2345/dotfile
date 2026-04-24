#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/../dotfile-installer/Brewfile"

if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Install it from https://brew.sh first."
  exit 1
fi

brew bundle dump --file="$BREWFILE" --formula --cask --force
echo "Dumped to $BREWFILE"
