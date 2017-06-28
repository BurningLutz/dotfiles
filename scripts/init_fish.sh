#!/bin/bash

echo /usr/local/bin/fish | sudo tee -a /etc/shells

echo 'Changing shell to fish, please enter your password.'
chsh -s /usr/local/bin/fish
