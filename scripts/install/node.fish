#!/usr/bin/env fish

if not type -q node
  switch (uname)
    case Darwin
      brew install node
    case Linux
      curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
      sudo apt install -y nodejs
  end
end
