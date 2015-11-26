#! /usr/bin/env bash

symlink_into_home_dir() {
  local file_name=`basename $1 | sed s/.symlink//`
  ln -sbr $1 "$HOME/.$file_name"
}

for file in `find . -path '*.symlink'` ; do
  symlink_into_home_dir $file
done

unset file
unset -f symlink_into_home_dir