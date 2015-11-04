#! /usr/bin/env bash

for file in `find . -name '*.sh' ! -name 'include.sh'` ; do
  . $file
done