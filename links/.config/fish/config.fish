if status --is-login
  # set fish_ambiguous_width to 1
  set -x fish_ambiguous_width 1

  # my default editor is neovim
  set -x EDITOR nvim
  # set locale archive for nix
  set -x LOCALE_ARCHIVE /usr/lib/locale/locale-archive
  # set lang
  set -x LANG en_US.UTF-8
  # set true color
  set -x COLORTERM truecolor
  # cabal config location
  set -x CABAL_CONFIG $HOME/.config/cabal/config
  # ghcup use XDG
  set -x GHCUP_USE_XDG_DIRS 1
end

if status --is-interactive
  # enhance ls
  alias ll="ls -lhAF"

  alias vim=nvim

  if type -q wslview
    alias open=wslview
  end

  # .local/bin
  fish_add_path --path $HOME/.local/bin
  # pyenv
  fish_add_path --path $HOME/.pyenv/bin
  # c lib & include
  set -x LIBRARY_PATH   "$HOME/.nix-profile/lib:$LIBRARY_PATH"
  set -x C_INCLUDE_PATH "$HOME/.nix-profile/include:$C_INCLUDE_PATH"
end
