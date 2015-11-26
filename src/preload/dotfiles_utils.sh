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

_complete_from() {
  local current_word
  COMPREPLY=()
  current_word=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -W '$@' -- $current_word ) )
  return 0
}

add_to_path() {
  local add_to_path="puts ENV['PATH'].split(':').push('$1').uniq.join(':')"
  export PATH=`ruby -e "$add_to_path"`
}
