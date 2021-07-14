#
# fzf configuration
#

## path
#if [[ "$OSTYPE" == darwin* ]]; then
#  if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin/* ]]; then
#    export PATH="/opt/homebrew/opt/fzf/bin
#    export PATH="${PATH:${PATH}:}/opt/homebrew/opt/fzf/bin"
#  fi
#fi

## auto-completion
[[ $- == *i* ]] && source "${HOME}/.dotfiles/libs/fzf/shell/completion.zsh" 2> /dev/null

## key bindings
source "${HOME}/.dotfiles/libs/fzf/shell/key-bindings.zsh"
