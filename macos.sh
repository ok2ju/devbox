#!/usr/bin/env bash
# macOS preferences. Safe to re-run. Some changes need a logout to take effect.
set -euo pipefail

# Finder: path bar, list view, new windows open the home folder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder NewWindowTarget -string PfHm

# Dock: icon size, no recent apps
defaults write com.apple.dock tilesize -float 41
defaults write com.apple.dock show-recents -bool false

# Trackpad: tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Menu bar: battery percentage
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

# Window tiling without gaps between windows
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# fn/Globe key does nothing
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# Screen saver after 10 minutes
defaults -currentHost write com.apple.screensaver idleTime -int 600

killall Finder Dock ControlCenter 2>/dev/null || true
