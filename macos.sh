#!/usr/bin/env bash
# macOS preferences. Safe to re-run. Some changes need a logout to take effect.
set -euo pipefail

# Finder: show all file extensions, path bar, status bar
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Dock: autohide, no recent apps
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false

# Trackpad: tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

killall Finder Dock 2>/dev/null || true
