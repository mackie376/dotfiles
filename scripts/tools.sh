#!/usr/bin/env bash

## git
mkdir -p "${HOME}/.ghq"
mkdir -p "${HOME}/Projects"
link_files "${DOTFILES_ETC_HOME}/git" "${XDG_CONFIG_HOME}/git"
show_ok git
