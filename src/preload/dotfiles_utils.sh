#! /usr/bin/env bash
on_mac() {
  if [ "$(uname)" == "Darwin" ]; then
    return 0
  else
    return 1
  fi
}

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

_complete_from() {
  local current_word
  COMPREPLY=()
  current_word=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -W '$@' -- $current_word ) )
  return 0
}
