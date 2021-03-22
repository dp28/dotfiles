#! /usr/bin/env bash

source_all() {
  for file in $@ ; do
    if [ -f $file ]; then
      source $file
    fi
  done
}

source_all `find $DOTFILES_HOME/src -path '*/preload/*.sh'`

source_all `find $DOTFILES_HOME/src -path '*.sh' ! -name 'include.sh' ! -path '*/preload/*.sh' ! -path '*/install/*' ! -path '*/.git/*'`
source_all `find $DOTFILES_HOME/src -path '*.bash'`

for bin_dir in `find $DOTFILES_HOME -path '*/bin'` ; do
  add_to_path $bin_dir
done

add_to_path ~/bin

unset file
unset bin_dir
