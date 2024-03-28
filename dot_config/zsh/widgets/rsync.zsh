#!/usr/bin/env zsh

if (( ! ${+commands[rsync]} )); then
  return 1
fi

_rsync_cmd='rsync --verbose --progress --human-readable --compress --archive --hard-links --one-file-system'

alias rsync-copy="${_rsync_cmd}"
alias rsync-move="${_rsync_cmd} --remove-source-files"
alias rsync-update="${_rsync_cmd} --update"
alias rsync-synchronize="${_rsync_cmd} --update --delete"

unset _rsync_cmd
