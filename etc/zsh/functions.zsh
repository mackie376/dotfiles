#!/usr/bin/env zsh

## fzf-cdr
function fzf-cdr() {
  local dir=$(cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf +m)
  if [[ -n "$dir" ]]; then
    BUFFER+="cd $dir"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-cdr

## fzf-ghq
function fzf-ghq() {
  local dir=$(ghq list --full-path | fzf +m)
  if [[ -n "$dir" ]]; then
    BUFFER+="cd $dir"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-ghq

## ts
function ts() {
  if [[ ! -n $TMUX && $- == *l* ]]; then
    ID="`tmux list-sessions`"
    create_new_session="Create new session"
    if [[ -n "$ID" ]]; then
      ID="$ID\n"
    fi
    ID="$ID${create_new_session}:"
    ID="`echo $ID | fzf | cut -d: -f1`"
    if [[ "$ID" == "${create_new_session}" ]]; then
      tmux new-session
    elif [[ -n "$ID" ]]; then
      tmux attach-session -t "$ID"
    fi
  fi
}
zle -N ts
