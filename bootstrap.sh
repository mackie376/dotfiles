#!/usr/bin/env bash

#
# variables
#

DOTFILES_HOME="${HOME}/.dotfiles"
DOTFILES_ETC_HOME="${DOTFILES_HOME}/etc"
DOTFILES_LIBS_HOME="${DOTFILES_HOME}/libs"
DOTFILES_SCRIPTS_HOME="${DOTFILES_HOME}/scripts"

XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.local/share"

#
# create XDG directory
#

mkdir -p "${XDG_CONFIG_HOME}"
mkdir -p "${XDG_CACHE_HOME}"
mkdir -p "${XDG_DATA_HOME}"

#
# utils
#

function is_macos() {
  [[ "$OSTYPE" == darwin* ]]
}

function show_status() {
  local text="$1"
  local status="$2"
  local color="$3"
  local reset="$(tput sgr0)"

  local empty_line="$(printf "%$((40-${#text}))s")"
  echo "${text} ${empty_line// /.} ${color}${status}${reset}"
}

function show_ok() {
  show_status "$1" "OK" "$(tput setaf 2)"
}

function show_na() {
  show_status "$1" "N/A" "$(tput setaf 3)"
}

#
# install 'xcode command line tools' for macOS
#

if is_macos; then
  if ! xcode-select --print-path &> /dev/null; then
    xcode-select --install &> /dev/null;
    until xcode-select --print-path &> /dev/null; do
      sleep 5
    done
  fi
fi

#
# configure
#

source "${DOTFILES_SCRIPTS_HOME}/macos.sh"

echo 'Done.'
