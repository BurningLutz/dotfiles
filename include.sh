#!/bin/bash

TARGET_DIR=~/.config/home-manager/pkgsets
PKGSETS_DIR=nix/pkgsets

#all pkgs
pkgs=$(ls $PKGSETS_DIR)

if [ -d $TARGET_DIR ]; then
  #diff sets
  pkgs=$(comm -23 <(ls $PKGSETS_DIR) <(ls $TARGET_DIR))
else
  mkdir -p $TARGET_DIR
fi

if [ $# -eq 0 ]; then
  for f in $pkgs; do
    echo $f
  done
else
  for arg in $@; do
    [[ $pkgs =~ (^|[[:space:]])$arg($|[[:space:]]) ]] \
      && echo "cp $arg to $TARGET_DIR" && cp $PKGSETS_DIR/$arg $TARGET_DIR/ \
      || echo -e "\e[33mwarn: ignore $arg\e[0m"
  done
fi
