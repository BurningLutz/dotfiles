#!/bin/bash

sudo apt install -y curl           \
                    libffi-dev     \
                    libffi8        \
                    libgmp-dev     \
                    libgmp10       \
                    libncurses-dev \
                    libncurses6    \
                    libtinfo6      \
                    libghc-gtk-dev \
                    llvm-15        \

# only install ghcup if not available
if ! type ghcup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
fi
