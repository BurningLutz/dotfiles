sudo apt-get install -y build-essential        \
                        curl                   \
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
if not type -q pyenv
  curl https://pyenv.run | bash
end

# only install when not available
if not type -q pdm
  curl -sSL https://raw.githubusercontent.com/pdm-project/pdm/main/install-pdm.py | python3 -
end
