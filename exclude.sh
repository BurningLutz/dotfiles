#!/bin/bash

TARGET_DIR=~/.config/home-manager/pkgsets

if [ -d $TARGET_DIR ]; then
  pkgs=$(ls $TARGET_DIR)
fi

if [ $# -eq 0 ]; then
  for f in $pkgs; do
    echo $f
  done
else
  for arg in $@; do
    echo "rm $arg"
    rm $TARGET_DIR/$arg
  done
fi
