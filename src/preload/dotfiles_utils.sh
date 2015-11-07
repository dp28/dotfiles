#! /usr/bin/env bash

contains_element() {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

run_in_dir() {
  local current_dir=`pwd`
  cd $1
  "${@:2}"
  cd $current_dir
}

dotfiles_help() {
  run_in_dir $DOTFILES_HOME _dotfiles_help "$@"
}

_dotfiles_help() {
  local spec_line=`_find_spec_line $1`

  if [ ${#spec_line} -eq 0 ]; then
    echo "No dotfiles help found for '$1'"
  else
    rspec $spec_line \
      | sed -e "/$1/,/Finished/!d" \
      | sed s/\ \ \ /*/ \
      | head -n -1 \
      | tail -n +2
  fi
}

_find_spec_line() {
  grep -rn --include=*_spec.rb "describe .$1. do" spec/ \
    | grep -o ".*: " \
    | sed s/:\ //
}