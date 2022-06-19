nix-env -iA nixpkgs.git                      \
            nixpkgs.ripgrep                  \
            nixpkgs.tldr                     \
            nixpkgs.unzip                    \
            nixpkgs.neovim                   \
            nixpkgs.nodejs                   \
            nixpkgs.yarn                     \
            nixpkgs.poetry                   \
            nixpkgs.nodePackages.js-beautify \

# win32yank
pushd /tmp
curl -fLO https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -o win32yank-x64.zip win32yank.exe
chmod +x win32yank.exe
mv win32yank.exe $HOME/.local/bin
popd

# add plug.vim to manage plugins
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -c PlugInstall -c qa
