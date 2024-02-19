# build means to produce all files needed by `home-manager switch`
source pkgset.fish

mkdir -p ~/.config/nix
mkdir -p ~/.config/home-manager
cp ../nix/nix.conf ~/.config/nix/
cp ../nix/home.nix ~/.config/home-manager/

set -x DOTFILES_PATH (realpath ..)
nix eval -f ../nix/vars.nix > ~/.config/home-manager/vars.nix

copy_pkgsets
