#!/usr/bin/env fish

if not type -q ghcup
  curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
end
