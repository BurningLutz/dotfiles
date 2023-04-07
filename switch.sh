#!/bin/bash

pushd scripts
sh setup_nix_config.sh
popd

home-manager switch
