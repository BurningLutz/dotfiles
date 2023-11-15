export DOTFILES_PATH=$(realpath $PWD/..)

cp ../nix/nix.conf ~/.config/nix/
cp ../nix/home.nix ~/.config/home-manager/
nix eval -f ../nix/vars.nix > ~/.config/home-manager/vars.nix

unset DOTFILES_PATH
