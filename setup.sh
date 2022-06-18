#!/bin/bash

SCRIPT_DIR=$( cd ${0%/*} && pwd -P )

if [[ $PWD != $SCRIPT_DIR ]]; then
  echo "Run setup.sh at its own directory." 1>&2
  exit 1
fi

# install fish first
nix-env -iA nixpkgs.fish

fish ./scripts/link_files.fish
fish --login ./scripts/install_general.fish
