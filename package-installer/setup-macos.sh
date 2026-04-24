#!/bin/bash

set -euo pipefail

header() { echo; echo "==> $*"; }
skip()   { echo "  skip: already set"; }
apply()  { echo "  set: $*"; }

set_default() {
  local domain="$1" key="$2" type="$3" value="$4"
  local current
  current="$(defaults read "$domain" "$key" 2>/dev/null || true)"
  if [[ "$current" == "$value" ]]; then
    skip "$key = $value"
  else
    defaults write "$domain" "$key" "$type" "$value"
    apply "$key = $value (was: ${current:-unset})"
  fi
}

# ---------------------------------------------------------------------------
# Keyboard
# ---------------------------------------------------------------------------
header "Keyboard"

# Key repeat rate (lower = faster; min is 1)
set_default NSGlobalDomain KeyRepeat -int 2

# Delay before key repeat starts (lower = shorter delay)
set_default NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold accent popup so key repeat works in all apps
set_default NSGlobalDomain ApplePressAndHoldEnabled -bool false

# ---------------------------------------------------------------------------
# Trackpad / Mouse
# ---------------------------------------------------------------------------
header "Trackpad & Mouse"

# Trackpad tracking speed (0–3, higher = faster)
set_default NSGlobalDomain com.apple.trackpad.scaling -float 3

# Mouse tracking speed (0–3, higher = faster)
set_default NSGlobalDomain com.apple.mouse.scaling -float 3

echo
echo "Done. Some changes may require logout/restart to take effect."
