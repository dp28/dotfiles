#! /usr/bin/env bash

# From https://gist.github.com/mwhite/6887990

if [ -f /usr/share/bash-completion/completions/git ] ; then
  . /usr/share/bash-completion/completions/git
fi

function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

_git_aliases() {
  git config --get-regexp "^alias\." |
    grep -o "alias\.\([[:alnum:]]*\)" |
    grep -o "\.\([[:alnum:]]*\)" |
    sed "s/\.//" |
    grep -v "^[[:space:]]*$"
}

for al in `_git_aliases`; do
  if [ $al != "pr" ]; then
    alias g$al="git $al"
    if [ "$(__git_aliased_command $al)" != "" ]; then
      complete_func=_git_$(__git_aliased_command $al)
      function_exists $complete_fnc && __git_complete g$al $complete_func
    fi
  fi
done
