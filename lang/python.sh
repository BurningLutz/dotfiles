#!/bin/bash

# common dependencies
sudo apt install -y python3-venv           \

# dependencies required by pyenv
sudo apt install -y curl                   \
                    libbz2-dev             \
                    libffi-dev             \
                    liblzma-dev            \
                    libncurses-dev         \
                    libreadline-dev        \
                    libsqlite3-dev         \
                    libssl-dev             \
                    libxml2-dev            \
                    libxmlsec1-dev         \
                    tk-dev                 \
                    xz-utils               \
                    zlib1g-dev             \
# dependencies required by matplotlib's qt backend.
sudo apt install -y qt6-base-dev           \

# only install when not available
if ! type pyenv >/dev/null 2>&1; then
  curl https://pyenv.run | bash
fi

# only install when not available
if ! type pdm >/dev/null 2>&1; then
  curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3 -
fi
