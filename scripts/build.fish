# build means to produce all files needed by `home-manager switch`
source pkgset.fish

mkdir -p ~/.config/nix
mkdir -p ~/.config/home-manager
cp ../nix/nix.conf ~/.config/nix/
cp ../nix/home.nix ~/.config/home-manager/
cp ../nix/replace.nix ~/.config/home-manager/

set -x DOTFILES_PATH (realpath ..)

set DOTFILES_USER_CONFIG_PATH ~/.config/dotfiles
set -x DOTFILES_USER_CONFIG $DOTFILES_USER_CONFIG_PATH/config.json
mkdir -p $DOTFILES_USER_CONFIG_PATH
if not test -e $DOTFILES_USER_CONFIG
  echo \
'{
  "HOME": "'$HOME'",
  "git.user": "example",
  "git.name": "example",
  "git.email": "example@gmail.com"
}'\
  > $DOTFILES_USER_CONFIG
  vim $DOTFILES_USER_CONFIG
end
echo -e "Your user config is (\033[0;33m$DOTFILES_USER_CONFIG\033[0m) :"; cat $DOTFILES_USER_CONFIG
echo ""

nix eval -f ../nix/vars.nix > ~/.config/home-manager/vars.nix

sync_pkgsets
