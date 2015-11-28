#! /usr/bin/env bash

dotfiles_help() {
  if [ $# -eq 0 ]; then
    echo "Available commands:"
    echo
    dotfiles_commands
  else
    run_in_dir $DOTFILES_HOME _dotfiles_help "$@"
  fi
}

dotfiles_commands() {
  run_in_dir $DOTFILES_HOME _find_documented_commands
}

_dotfiles_help() {
  local spec_line=`_find_spec_line $1`

  if [ ${#spec_line} -eq 0 ]; then
    echo "No dotfiles help found for '$1'"
  else
    rspec $spec_line --color --tty \
      | sed -e "/$1/,/Finished/!d" \
      | sed s/\ \ \ \ // \
      | head -n -1 \
      | tail -n +2
  fi
}

_find_spec_line() {
  grep -rn --include=*_spec.rb "describe .$ $1. do" spec/ \
    | grep -o ".*: " \
    | sed s/:\ //
}

_find_documented_commands() {
  grep -rn --include=*_spec.rb "describe '$ .*' do" spec/ \
    | grep -o "$ .*'" \
    | sed s/$\ // \
    | sed "s/'//"
}