#!/usr/bin/env bash

## anyenv
if [[ ! -e "${HOME}/.anyenv" ]]; then
  ln -s "${DOTFILES_LIBS_HOME}/anyenv" "${HOME}/.anyenv"
fi
show_ok anyenv

## fzf
if is_debian; then
  if [[ ! -e /usr/local/bin/fzf ]]; then
    "${DOTFILES_LIBS_HOME}/fzf/install" --bin
    sudo mv "${DOTFILES_LIBS_HOME}/fzf/bin/fzf" /usr/local/bin
    sudo chown root:root /usr/local/bin/fzf
  fi
fi
link_files "${DOTFILES_ETC_HOME}/fzf" "${XDG_CONFIG_HOME}/fzf"
show_ok fzf

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

## karabiner-elements
if is_macos; then
  link_files "${DOTFILES_ETC_HOME}/karabiner" "${XDG_CONFIG_HOME}/karabiner"
  show_ok karabiner-elements
else
  show_na karabiner-elements
fi

## neovim
link_files "${DOTFILES_ETC_HOME}/neovim" "${XDG_CONFIG_HOME}/nvim"
show_ok neovim

## tmux
if [[ ! -e "${HOME}/.tmux.conf" ]]; then
  ln -s "${DOTFILES_ETC_HOME}/tmux/tmux.conf" "${HOME}/.tmux.conf"
fi
show_ok tmux

## xfce4-terminal
if is_debian; then
  link_files "${DOTFILES_ETC_HOME}/xfce4-terminal" "${XDG_CONFIG_HOME}/xfce4/terminal"
  show_ok xfce4-terminal
else
  show_na xfce4-terminal
fi

## zsh
PATH=/opt/homebrew/bin:$PATH
mkdir -p "${XDG_CONFIG_HOME}/zsh"
ln -sf "${DOTFILES_ETC_HOME}/zsh/zshenv" "${HOME}/.zshenv"
ln -sf "${DOTFILES_ETC_HOME}/zsh/zlogin" "${XDG_CONFIG_HOME}/zsh/.zlogin"
ln -sf "${DOTFILES_ETC_HOME}/zsh/zlogout" "${XDG_CONFIG_HOME}/zsh/.zlogout"
ln -sf "${DOTFILES_ETC_HOME}/zsh/zpreztorc" "${XDG_CONFIG_HOME}/zsh/.zpreztorc"
ln -sf "${DOTFILES_ETC_HOME}/zsh/zprofile" "${XDG_CONFIG_HOME}/zsh/.zprofile"
ln -sf "${DOTFILES_ETC_HOME}/zsh/zshrc" "${XDG_CONFIG_HOME}/zsh/.zshrc"
ln -sf "${DOTFILES_ETC_HOME}/zsh/functions.zsh" "${XDG_CONFIG_HOME}/zsh/.functions.zsh"
if [[ -n "$(which zsh)" ]]; then
  if ! grep "$(which zh)" -rl /etc/shells &> /dev/null; then
    echo "$(which zsh)" | sudo tee -a /etc/shells &> /dev/null
  fi
fi
show_ok zsh
