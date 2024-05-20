#!/usr/bin/env bash

defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write com.apple.dock persistent-apps --array
defaults write com.apple.dock persistent-others --array
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock springboard-columns -int 12
defaults write com.apple.dock springboard-rows -int 8
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture name -string 'capture-'
defaults write com.apple.screencapture type -string 'jpg'

softwareupdate --install-rosetta --agree-to-license

touch "${HOME}/.hushlogin"

rm -f ~/*/.localized
rm -f /Applications/.localized

killall Finder
killall Dock
killall SystemUIServer
