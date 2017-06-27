#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install nginx \
              fish \
              node \
            neovim \
              yarn \
             rbenv \
        ruby-build
