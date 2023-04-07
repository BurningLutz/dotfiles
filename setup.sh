#!/bin/bash

SCRIPT_DIR=$(cd ${0%/*} && pwd -P)

if [[ $PWD != $SCRIPT_DIR ]]; then
  echo "Run setup.sh at its own directory." 1>&2
  exit 1
fi

echo "Setuping..."

pushd scripts
. setup_system_requirements.sh
. setup_nix.sh
. setup_general.sh
popd

# change login shell to fish
echo "Changing default login shell to fish..."
chsh -s $(which fish)

echo "All setups are done. Congrats!"
