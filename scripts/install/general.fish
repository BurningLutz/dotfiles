#!/usr/local/bin/fish

brew tap z80oolong/tmux

set -l bins   nginx \
               node \
                git \
          leiningen \
                 ag \
                 rg \
z80oolong/tmux/tmux \
               tldr

for bin in $bins
  if not brew ls --versions $bin > /dev/null
    brew install $bin
  end
end
