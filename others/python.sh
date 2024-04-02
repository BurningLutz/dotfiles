#!/bin/bash

# common dependencies
sudo apt install -y python3-venv     \
# dependencies required by pyenv
sudo apt install -y curl             \
                    libbz2-dev       \
                    libffi-dev       \
                    liblzma-dev      \
                    libncursesw5-dev \
                    libreadline-dev  \
                    libsqlite3-dev   \
                    libssl-dev       \
                    libxml2-dev      \
                    libxmlsec1-dev   \
                    tk-dev           \
                    xz-utils         \
                    zlib1g-dev       \
# dependencies required by matplotlib's qt backend.
sudo apt install -y qt6-base-dev     \
