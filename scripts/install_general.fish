nix-env -iA nixpkgs.git                      \
            nixpkgs.ripgrep                  \
            nixpkgs.tldr                     \
            nixpkgs.unzip                    \
            nixpkgs.neovim                   \
            nixpkgs.nodejs                   \
            nixpkgs.yarn                     \
            nixpkgs.poetry                   \
            nixpkgs.nodePackages.js-beautify \

# add plug.vim to manage plugins
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -c PlugInstall -c qa
