#!/usr/bin/env zsh

function widget::tmux::source() {
  local blue="\e[34m"
  local reset="\e[m"
  local icon="\uebc8"

  local session_list=($(tmux list-session -F '#S' 2> /dev/null))
  for session in "${session_list[@]}"; do
    printf "$blue$icon %s$reset\n" "$session"
  done
}

function widget::tmux::select() {
  widget::tmux::source | fzf-tmux -w90% -h75% --ansi --exit-0 | cut -d ' ' -f2-
}

function widget::tmux::session() {
  local selected="$(widget::tmux::select)"
  if [[ -z "$selected" ]]; then
    return
  fi

  local session_name="${selected//[:. ]/-}"
  local repo_dir
  if [[ "$selected" == "dotfiles" ]]; then
    repo_dir="${XDG_DATA_HOME}/chezmoi"
  else
    repo_dir="$(ghq list --exact --full-path "$selected")"
  fi

  if [[ -z "$TMUX" ]]; then
    BUFFER="tmux new-session -A -s ${(q)session_name} -c ${(q)repo_dir}"
    zle accept-line
  elif [[ "$(tmux display-message -p "#S")" != "$session_name" ]]; then
    tmux new-session -d -s "$session_name" 2> /dev/null
    tmux switch-client -t "$session_name"
  fi

  zle -R -c
}

zle -N widget::tmux::session
