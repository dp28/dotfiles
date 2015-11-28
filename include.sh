#! /usr/bin/env bash

source_all() {
  local file
  for file in "$@" ; do
    . $file
  done
}

source_all `find $DOTFILES_HOME/src -path '*/preload/*.sh'`

source_all `find $DOTFILES_HOME/src -path '*.sh' ! -name 'include.sh' ! -path '*/preload/*.sh' ! -path '*/install/*'`

if [ -n "$ZSH_VERSION" ]; then
  source_all `find $DOTFILES_HOME/src -path '*.zsh'`
elif [ -n "$BASH_VERSION" ]; then
  source_all `find $DOTFILES_HOME/src -path '*.bash'`
fi

for bin_dir in `find $DOTFILES_HOME -path '*/bin'` ; do
  add_to_path $bin_dir
done

unset file
unset bin_dir