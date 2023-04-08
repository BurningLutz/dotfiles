#!/bin/bash

sudo apt install -y curl                   \
                    gir1.2-gtk-3.0         \
                    libbz2-dev             \
                    libcairo2-dev          \
                    libffi-dev             \
                    libgirepository1.0-dev \
                    liblzma-dev            \
                    libncursesw5-dev       \
                    libreadline-dev        \
                    libsqlite3-dev         \
                    libssl-dev             \
                    libxml2-dev            \
                    libxmlsec1-dev         \
                    llvm                   \
                    pkg-config             \
                    python3-dev            \
                    python3-venv           \
                    tk-dev                 \
                    wget                   \
                    xz-utils               \
                    zlib1g-dev             \

# only install when not available
if ! type pyenv >/dev/null 2>&1; then
  curl https://pyenv.run | bash
fi

# only install when not available
if ! type pdm >/dev/null 2>&1; then
  curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3 -
fi
