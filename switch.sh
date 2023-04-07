#!/bin/bash

pushd scripts
. setup_nix_config.sh
popd

home-manager switch
