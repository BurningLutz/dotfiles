#!/bin/bash

pushd scripts 1>/dev/null
. setup_nix_config.sh
popd 1>/dev/null

home-manager switch
