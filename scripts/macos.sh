#!/usr/bin/env bash

if is_macos; then
  TARGET_FONT_DIR="${HOME}/Library/Fonts"

  ## system
  defaults write com.apple.dock persistent-apps -array
  defaults write com.apple.dock persistent-others -array
  defaults write com.apple.dock autohide-delay -float 0
  defaults write com.apple.dock autohide-time-modifier -float 0.5
  defaults write com.apple.dock springboard-columns -int 12
  defaults write com.apple.dock springboard-rows -int 8
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.screencapture location -string "${HOME}/Desktop"
  defaults write com.apple.screencapture name -string 'capture-'
  defaults write com.apple.screencapture type -string 'jpg'

  ## erase localized files
  rm -f ~/*/.localized
  rm -f /Applications/.localized

  ## reset user interface
  killall Finder
  killall Dock
  killall SystemUIServer

  ## install 'rosetta2'
  if ! hash arch; then
    softwareupdate --install-rosetta
  fi

  ## install 'DynaFont'
  SRC_DYNAFONT_DIR="${HOME}/Library/Mobile Documents/com~apple~CloudDocs/DynaFont"
  rsync -a "$SRC_DYNAFONT_DIR"/*.ttc "$SRC_DYNAFONT_DIR"/*.TTC "$TARGET_FONT_DIR"

  ## install 'Homebrew'
  if [[ ! -x "/opt/homebrew/bin/brew" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  ## install tools
  BREWFILE_PATH="${DOTFILES_HOME}/libs/brewfile"
  PATH=/opt/homebrew/bin:$PATH
  if [[ -n "$BREWFILE_PATH" ]]; then
    brew bundle install --no-lock --file="$BREWFILE_PATH"
  fi

  show_ok 'macOS'
else
  show_na 'macOS'
fi
