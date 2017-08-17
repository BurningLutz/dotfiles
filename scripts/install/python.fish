#!/usr/local/bin/fish

if not brew ls --versions python > /dev/null
  brew install python
  pip install neovim
end

if not brew ls --versions python3 > /dev/null
  brew install python3
  pip3 install neovim
end
