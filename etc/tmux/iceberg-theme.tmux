#!/usr/bin/env zsh

#
# colors
#

background='#161821'
foreground='#c6c8d1'

black='#272c42'
white='#6b7089'
blue='#84a0c6'
gray='#3d425b'
yellow='#e4aa80'

#
# characters
#

## separator
separator_left="\ue0b0"
separator_right="\ue0b2"
separator_sub_left="\ue0b1"
separator_sub_right="\ue0b3"

#
# functions
#

function set() {
  local option="$1"
  local value="$2"
  tmux set-option -gq "$option" "$value"
}

#
# status line
#

## basic
set status           on
set status-interval  1
set status-justify   left

## color
set status-style "bg=default,fg=$foreground"

## layout
set status-position      bottom
set status-left-length   1000
set status-right-length  1000

## section 'A'
function section_A() {
  local format="#[bold]#[bg=%s]#[fg=%s] #S #[bg=%s]#[fg=%s]${separator_left}"

  local normal=$(printf $format $white $black $black $white)
  local active=$(printf $format $blue $black $black $blue)
  printf "#{?client_prefix,$active,$normal}#[default]"
}

## section 'B'
function section_B() {
  local format="#[bg=%s]#[fg=%s] %%Y-%%m-%%d %%a. #[bg=%s]#[fg=%s]${separator_left}"
  printf $format $black $white $background $black
}

## section 'C'
function section_C() {
  echo ''
}

## section 'X'
function section_X() {
  echo ''
}

## section 'Y'
function section_Y() {
  local format="#[bg=%s]#[fg=%s]${separator_right}#[bg=%s]#[fg=%s] #{load_average} ${separator_sub_right} #{public_ip} "
  printf $format $background $black $black $white
}

## section 'Z'
function section_Z() {
  local format="#[bold]#[bg=%s]#[fg=%s]${separator_right}#[bg=%s]#[fg=%s] #H "

  local normal=$(printf $format $black $white $white $background)
  local active=$(printf $format $black $blue $blue $black)
  printf "#{?client_prefix,$active,$normal}#[default]"
}

## format
set status-left   "$(section_A)$(section_B)$(section_C)#[default]"
set status-right  "$(section_X)$(section_Y)$(section_Z)#[default]"

#
# window
#

## style
set window-status-separator ''

## section 'W'
function section_W() {
  local active="$1"
  local format="#[bg=%s]#[fg=%s]${separator_left}#[bg=%s]#[fg=%s] #I ${separator_sub_left} #W #[bg=%s]#[fg=%s]${separator_left}"

  if [[ -z $active ]]; then
    printf $format $background $background $background $gray $background $background
  else
    printf $format $white $background $white $black $background $white
  fi
}

## format
set window-status-format          "$(section_W)#[default]"
set window-status-current-format  "$(section_W active)#[default]"

#
# pane
#

## basic
set pane-border-status  bottom

## style
set pane-border-style         "bg=default,fg=$black"
set pane-active-border-style  "bg=default,fg=$white"

## section 'P'
function section_P() {
  local format="#[bg=%s]#[fg=%s] #P "
  local normal=$(printf $format default $gray)
  local active=$(printf $format $white $background)
  echo "#{?pane_active,$active,$normal}"
}

## format
set pane-border-format  "$(section_P)#[default]"

#
# message
#

## style
set message-style  "bg=default,fg=$yellow"

#
# mode
#

## style
set mode-style  "bg=$yellow,fg=$background"

#
# clock
#

## style
set clock-mode-colour  $yellow
set clock-mode-style   24
