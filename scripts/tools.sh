#!/usr/bin/env bash

## git
mkdir -p "${HOME}/.ghq"
mkdir -p "${HOME}/Projects"
link_files "${DOTFILES_ETC_HOME}/git" "${XDG_CONFIG_HOME}/git"
show_ok git

## gnupg
if is_macos; then
  link_files "${DOTFILES_ETC_HOME}/gnupg" "${HOME}/.gnupg"
  chmod og-rx "${HOME}/.gnupg"
  show_ok gnupg
else
  show_na gnupg
fi
