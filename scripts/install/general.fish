#!/usr/bin/env fish

set -l bins git ripgrep tldr

for bin in $bins
  switch (uname)
    case Darwin
      brew install $bin
    case Linux
      sudo apt install -y $bin
  end
end
