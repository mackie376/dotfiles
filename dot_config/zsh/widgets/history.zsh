#!/usr/bin/env zsh

function zshaddhistory() {
  local line="${1%%$'\n'}"
  [[ ! "$line" =~ "^(cd|lazygit|la|ll|ls|rm)($| )" ]]
}

function widget::history() {
  local selected="$(history -inr 1 | fzf-tmux -w90% -h75% --exit-0 --query "$LBUFFER" | cut -d' ' -f4- | sed 's/\\n/\n/g')"
  if [[ -n "$selected" ]]; then
    BUFFER="$selected"
    CURSOR="$#BUFFER"
  fi
  zle -R -c
}

zle -N widget::history
