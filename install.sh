#!/bin/bash

SCRIPT_DIR=$( cd ${0%/*} && pwd -P )

if [[ $PWD != $SCRIPT_DIR ]]; then
  echo "Run install.sh at its own directory." 1>&2
  exit 1
fi

# install brew if not exists
if [[ ! -x $( command -v brew ) ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install fish if not exists, and eagerly use it
if [[ ! -x $( command -v fish ) ]]; then
  ./scripts/install_fish.sh
fi

./scripts/link_files.fish
