#! /usr/bin/env bash

original_dir=`pwd`
mkdir -p .dependencies
cd .dependencies

regex="^.*/(.*)\$"
[[ $1 =~ $regex ]]
repo="${BASH_REMATCH[1]}"
git clone https://github.com/$1.git
cd $repo
sudo make
cd ../

cd $original_dir
unset original_dir
unset repo
unset regex