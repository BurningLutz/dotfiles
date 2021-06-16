#!/bin/bash

switch (uname)
  case Darwin
    brew install fish
    echo /usr/local/bin/fish | sudo tee -a /etc/shells
  case Linux
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt update
    sudo apt install fish
end

echo 'Changing shell to fish, please enter your password.'
chsh -s /usr/local/bin/fish
