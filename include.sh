#! /usr/bin/env bash

for file in `find . -path '*/preload/*.sh'` ; do
  . $file
done

for file in `find . -path '*.sh' ! -name 'include.sh' ! -path '*/preload/*.sh'`
do
  . $file
done

unset file