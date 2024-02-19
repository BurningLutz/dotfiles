# cleanups.
#
# reinstalling nix means delete and then install. :D
sudo rm -rf /nix
rm -rf ~/.nix-channels ~/.nix-profile ~/.nix-defexpr
rm -rf ~/.local/share/nix
rm -rf ~/.local/state/nix
rm -rf ~/.local/share/home-manager
rm -rf ~/.local/state/home-manager

# install nix and load it.
#
# DO NOT ALLOW nix to modify profile files.
export NIX_INSTALLER_NO_MODIFY_PROFILE=1
bash <(curl -L https://nixos.org/nix/install) --no-daemon

# load nix for further home-manager installation.
source ~/.nix-profile/etc/profile.d/nix.sh

# install home-manager.
#
# mitigate home files' conflicts.
for fp in $(find ../homefiles -type f,l | sed "s|^../homefiles/||"); do
  rm -f ~/$fp
done

# build files for further `home-manager switch`.
fish build.fish

# and then install. no need to run `home-manager switch`, the installation will run it once.
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell "<home-manager>" -A install
