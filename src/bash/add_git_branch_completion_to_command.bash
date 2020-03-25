#! /usr/bin/env bash

if [ $# -ne 1 ]; then return ; fi

_add_branch_completion() {
  local current_word
  local branches
  COMPREPLY=()

  branches=`git branch -a | sed -e 's/\*//' -e 's/remotes\///g' | tr '\n' ' '`

  current_word=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -W "$branches" -- $current_word ) )
  return 0
}

complete -F _add_branch_completion "$1"
