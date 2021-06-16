#!/bin/bash

case $(uname) in
  Darwin)
    brew install fish
    echo /usr/local/bin/fish | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/fish
  ;;
  Linux)
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt update
    sudo apt install -y fish
    chsh -s /usr/bin/fish
  ;;
esac
