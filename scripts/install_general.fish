# add wslu entry from ppa
sudo apt remove wslu -y
sudo add-apt-repository ppa:wslutilities/wslu -y

# and install necessary packages
sudo apt update
sudo apt install -y build-essential wslu

# common tools
nix-env -iA nixpkgs.git                                     \
            nixpkgs.fd                                      \
            nixpkgs.ripgrep                                 \
            nixpkgs.htop                                    \
            nixpkgs.tldr                                    \
            nixpkgs.unzip                                   \
            nixpkgs.neovim                                  \
            nixpkgs.nodejs                                  \
            nixpkgs.pyright                                 \
            nixpkgs.sumneko-lua-language-server             \
            nixpkgs.nodePackages.js-beautify                \
            nixpkgs.nodePackages.typescript                 \
            nixpkgs.nodePackages.typescript-language-server \

# only install win32yank when not available
if not type -q win32yank.exe
  set ZIPNAME (mktemp)
  set EXENAME (mktemp)

  curl -fL -o $ZIPNAME https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
  unzip -p $ZIPNAME win32yank.exe > $EXENAME
  chmod +x $EXENAME
  mv $EXENAME $HOME/.local/bin/win32yank.exe
end

# only install packer.nvim to manage plugins when not available
set PACKERPATH $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
if not test -d $PACKERPATH
  git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKERPATH
  nvim --headless -c "autocmd User PackerComplete quitall" -c PackerSync
end
