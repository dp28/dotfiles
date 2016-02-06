#! /usr/bin/env bash

versioned_config=$DOTFILES_HOME/src/git/config
local_config=~/.gitconfig

if [ -f $local_config ] ; then
  if ! grep $versioned_config $local_config 2>&1 > /dev/null ; then
    echo "[include]" >> $local_config
    echo "  path = $versioned_config ;" >> $local_config
  fi
else
  cp $versioned_config $local_config
fi

unset versioned_config