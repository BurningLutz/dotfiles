#!/bin/bash

SCRIPT_DIR=$( cd ${0%/*} && pwd -P )

if [[ $PWD != $SCRIPT_DIR ]]; then
  echo "Run install.sh at its own directory." 1>&2
  exit 1
fi

if [[ $(uname) == "Linux" ]]; then
  sudo apt update
  sudo apt install -y build-essential curl libffi-dev libffi7 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5
fi

./scripts/link_files.fish
./scripts/install_general.fish
