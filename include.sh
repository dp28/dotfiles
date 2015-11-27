#! /usr/bin/env bash

DOTFILES_HOME=~/Programming/Other/dotfiles

for file in `find ./src -path '*/preload/*.sh'` ; do
  . $file
done

for file in `find ./src -path '*.sh' ! -name 'include.sh' ! -path '*/preload/*.sh' ! -path '*/install/*'`
do
  . $file
done

for bin_dir in `find $DOTFILES_HOME -path '*/bin'` ; do
  add_to_path $bin_dir
done

unset file
unset bin_dir