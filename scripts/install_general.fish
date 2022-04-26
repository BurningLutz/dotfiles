#!/usr/bin/env fish

set -l bins git ripgrep tldr unzip neovim nodejs npm

switch (uname)
  case Darwin
    brew install $bins
  case Linux
    sudo apt install -y $bins
end

set -l node_bins neovim js-beautify
sudo npm i -g $node_bins

# add plug.vim to manage plugins
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -c PlugInstall -c qa
