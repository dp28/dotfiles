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