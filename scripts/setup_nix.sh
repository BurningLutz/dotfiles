# reinstall nix
sudo rm -rf /nix

# install nix and load it
export NIX_INSTALLER_NO_MODIFY_PROFILE=1

sh <(curl -L https://nixos.org/nix/install) --no-daemon

. /home/lutz/.nix-profile/etc/profile.d/nix.sh

# install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell "<home-manager>" -A install
