# reinstalling nix means delete and then install :D
sudo rm -rf /nix

# copy configs
mkdir -p ~/.config/nix
mkdir -p ~/.config/home-manager
bash setup_nix_config.sh

# install nix and load it
export NIX_INSTALLER_NO_MODIFY_PROFILE=1

bash <(curl -L https://nixos.org/nix/install) --no-daemon

. /home/lutz/.nix-profile/etc/profile.d/nix.sh

# install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell "<home-manager>" -A install
