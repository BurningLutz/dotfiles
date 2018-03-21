#!/usr/local/bin/fish

set -l bins nginx \
             node \
              git \
        leiningen \
               ag \
             tmux \
             tldr

for bin in $bins
  if not brew ls --versions $bin > /dev/null
    brew install $bin
  end
end
