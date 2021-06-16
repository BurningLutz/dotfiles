#!/usr/bin/env fish

if not type -q nvim
  switch (uname)
    case Darwin
      brew install neovim
    case Linux
      sudo apt install neovim
  end

  # add plug.vim to manage plugins
  curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end

nvim -c PlugInstall -c qa
