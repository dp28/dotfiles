#! /usr/bin/env bash

DOTFILES_MODES=(test normal)

dotfiles_mode() {
  if [ $# -eq 0 ]; then
    show_dotfiles_mode
  elif [ $# -eq 1 ]; then
    set_dotfiles_mode $1
  else
    echo "Invalid number of arguments for 'dotfiles_mode'"
  fi
}

show_dotfiles_mode() {
  if [ $DOTFILES_MODE = 'normal' ]; then
    message="'run' echoes and executes commands"
  else
    message="'run' only echoes commands"
  fi
  echo "Mode: '$DOTFILES_MODE' - $message"
}

set_dotfiles_mode() {
  if contains_element $1 ${DOTFILES_MODES[@]} ; then
    export DOTFILES_MODE="$1"
  else
    echo "Invalid mode '$1'. Possible modes: 'test', 'normal'"
  fi
  show_dotfiles_mode
}

if [ -z "$DOTFILES_MODE" ]; then
  set_dotfiles_mode normal
fi

run() {
  echo "$@"
  if [ $DOTFILES_MODE = 'normal' ]; then
  "$@"
  fi
}
