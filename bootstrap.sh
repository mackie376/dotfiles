#!/usr/bin/env bash

set -eu

# --------------------------------------------------------------------------

XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.local/share"
XDG_STATE_HOME="${HOME}/.local/state"
XDG_BIN_HOME="${HOME}/.local/bin"

PROJECTS_DIR="${HOME}/Projects"

# --------------------------------------------------------------------------

mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_STATE_HOME"
mkdir -p "$XDG_BIN_HOME"
mkdir -p "$PROJECTS_DIR"

# --------------------------------------------------------------------------

KERNEL_NAME="$(uname -s)"

# --------------------------------------------------------------------------

if [[ "$KERNEL_NAME" =~ 'Linux' ]]; then
  if ! which curl &> /dev/null; then
    sudo apt install -y curl
  fi
  if ! which git &> /dev/null; then
    sudo apt install -y git
  fi
fi

# --------------------------------------------------------------------------

if [[ "$KERNEL_NAME" =~ 'Darwin' ]]; then
  if ! xcode-select --print-path &>/dev/null; then
    xcode-select --install &>/dev/null
    until xcode-select --print-path &>/dev/null; do
      sleep 5
    done
  fi
  if [[ ! -x /opt/homebrew/bin/brew ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --------------------------------------------------------------------------

if [[ ! -x "${XDG_BIN_HOME}/chezmoi" ]]; then
  sh -c "$(curl -fsSL get.chezmoi.io)" -- -b "$XDG_BIN_HOME"
fi

if [[ ! -x "${XDG_BIN_HOME}/mise" ]]; then
  curl https://mise.run | sh
fi

export PATH="$XDG_BIN_HOME:$PATH"

# --------------------------------------------------------------------------

echo -e "\nDone.\n"
