#!/bin/bash

sudo su $USER

SCRIPT_DIR=$( cd ${0%/*} && pwd -P )

if [[ $PWD != $SCRIPT_DIR ]]; then
  echo "Run install.sh at its own directory." 1>&2
  exit 1
fi

./scripts/install_homebrew.sh
./scripts/link.sh
./scripts/init_fish.sh
./scripts/init_yarn.sh
./scripts/init_python.sh
./scripts/init_ruby.sh
./scripts/init_neovim.sh

