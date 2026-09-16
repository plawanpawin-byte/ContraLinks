#!/bin/bash
# Run this on the Mac after cloning: bash setup.sh
# Installs Homebrew (if missing) + XcodeGen, generates the Xcode project,
# and opens it. Avoids needing to copy/paste multiple commands over a
# remote desktop session where clipboard sync is unreliable.
set -e

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found — installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

if ! command -v xcodegen >/dev/null 2>&1; then
  echo "Installing XcodeGen..."
  brew install xcodegen
fi

echo "Generating ContraLinks.xcodeproj..."
xcodegen generate

echo "Opening in Xcode..."
open ContraLinks.xcodeproj

echo "Done. In Xcode: select the ContraLinks target -> Signing & Capabilities -> pick your Apple ID as Team."
