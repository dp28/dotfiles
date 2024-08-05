#! /usr/bin/env bash

symlink_into_home_dir() {
  local file_name=`basename $1 | sed s/.symlink//`
  if [ on_mac ]; then
    ln -s $1 "$HOME/.$file_name"
  else
    ln -sbr $1 "$HOME/.$file_name"
  fi
}

for file in `find $DOTFILES_HOME -path '*.symlink'` ; do
  symlink_into_home_dir $file
done

unset file
unset -f symlink_into_home_dir
