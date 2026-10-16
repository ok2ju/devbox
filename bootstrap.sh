#!/usr/bin/env bash
# Sets up a Mac from this repo. Safe to re-run.
set -euo pipefail
cd "$(dirname "$0")"

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Finish the Command Line Tools install, then re-run ./bootstrap.sh"
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# ponytail: Apple Silicon only, Intel Macs use /usr/local/bin/brew
eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle --file=Brewfile
chezmoi init --apply --source="$PWD"
mise install
git config core.hooksPath .githooks
./macos.sh

echo "Done. Open a new terminal. Run 'colima start' before using docker."
