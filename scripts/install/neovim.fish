#!/usr/local/bin/fish

if not brew ls --versions neovim > /dev/null
  brew install neovim

  # add plug.vim to manage plugins
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end

nvim -c PlugInstall -c qa
