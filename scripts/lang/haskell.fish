sudo apt install -y curl            \
                    libffi-dev      \
                    libffi8ubuntu1  \
                    libgmp-dev      \
                    libgmp10        \
                    libncurses-dev  \
                    libncurses5     \
                    libtinfo5

# only install ghcup if not available
if not type -q ghcup
  curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
end
