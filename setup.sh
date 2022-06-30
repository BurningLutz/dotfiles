#!/bin/bash

SCRIPT_DIR=$( cd ${0%/*} && pwd -P )

if [[ $PWD != $SCRIPT_DIR ]]; then
  echo "Run setup.sh at its own directory." 1>&2
  exit 1
fi

# install fish first
nix-env -iA nixpkgs.fish

# add fish support
FISH=$(which fish)
if ! grep -qwF $FISH /etc/shells; then
  echo "Add fish as a valid login shell..."
  echo $FISH | sudo tee -a /etc/shells
fi
# change login shell to fish
echo "Change default login shell to fish..."
chsh -s $FISH

fish ./scripts/link_files.fish
fish --login ./scripts/install_general.fish
