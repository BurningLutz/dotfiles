# reinstalling nix means delete and then install :D
sudo rm -rf /nix
rm -rf ~/.nix-channels ~/.nix-profile ~/.nix-defexpr

# copy configs
mkdir -p ~/.config/nix
mkdir -p ~/.config/home-manager
. setup_nix_config.sh

# install nix and load it
export NIX_INSTALLER_NO_MODIFY_PROFILE=1

bash <(curl -L https://nixos.org/nix/install) --no-daemon

. $HOME/.nix-profile/etc/profile.d/nix.sh

# copy variables
export DOTFILES_PATH=$(realpath $PWD/..)
nix eval -f ../nix/vars.nix > ~/.config/home-manager/vars.nix

# mitigate home file conflicts
for fp in $(find ../homefiles -type f,l | sed "s|^../homefiles/||"); do
  rm -f ~/$fp
done

# install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell "<home-manager>" -A install
