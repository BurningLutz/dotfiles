#!/bin/bash

rbenv init

# install default gems when installing new version of ruby using rbenv
git clone https://github.com/rbenv/rbenv-default-gems.git \
          $(rbenv root)/plugins/rbenv-default-gems

echo """
bundler
gem-ctags
neovim
rubocop
""" > $(rbenv root)/default-gems

git clone git://github.com/tpope/rbenv-ctags.git \
          $(rbenv root)/plugins/rbenv-ctags

rbenv install 2.4.1
rbenv global 2.4.1
