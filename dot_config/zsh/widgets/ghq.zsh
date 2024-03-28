#!/usr/bin/env zsh

function widget::ghq::source() {
  local session
  local color
  local icon
  local green="\e[32m"
  local blue="\e[34m"
  local reset="\e[m"
  local opened="\ue5fe"
  local unopened="\ue5ff"

  local session_list=($(tmux list-sessions -F '#S' 2> /dev/null))
  local candidate_list=($(ghq list | sort) 'dotfiles')
  for repo in "${candidate_list[@]}"; do
    session="${repo//[:. ]/-}"
    color="$blue"
    icon="$unopened"
    if (( ${+session_list[(r)$session]} )); then
      color="$green"
      icon="$opened"
    fi
    printf "$color$icon %s$reset\n" "$repo"
  done
}

function widget::ghq::select() {
  widget::ghq::source | fzf-tmux -w90% -h75% --ansi --exit-0 --preview="fzf-preview-ghq {+2}" --preview-window="right:60%,border-left" | cut -d ' ' -f2-
}

function widget::ghq::dir() {
  local selected="$(widget::ghq::select)"
  if [[ -z "$selected" ]]; then
    return
  fi

  local repo_dir
  if [[ "$selected" == "dotfiles" ]]; then
    repo_dir="${XDG_DATA_HOME}/chezmoi"
  else
    repo_dir="$(ghq list --exact --full-path "$selected")"
  fi
  BUFFER="cd ${(q)repo_dir}"
  zle accept-line
  zle -R c
}

function widget::ghq::session() {
  local selected="$(widget::ghq::select)"
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
  elif [[ "$(tmux display-message -p "#S")" == "$session_name" ]] && [[ "$PWD" != "$repo_dir" ]]; then
    BUFFER="cd ${(q)repo_dir}"
    zle accept-line
  else
    tmux new-session -d -s "$session_name" -c "$repo_dir" 2> /dev/null
    tmux switch-client -t "$session_name"
  fi
  zle -R -c
}

zle -N widget::ghq::dir
zle -N widget::ghq::session
