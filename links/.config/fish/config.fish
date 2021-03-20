if status --is-login
  # my default editor is neovim
  set -x EDITOR nvim

  # set fish_ambiguous_width to 1
  set -x fish_ambiguous_width 1

  # set lang
  set -x LANG en_US.UTF-8
end

if status --is-interactive
  # enhance ls
  alias ll="ls -lhAFG"

  alias vim=nvim

  alias poe=poetry

  # pyenv and pyenv virtualenv related
  source (pyenv init -|psub)
  source (pyenv virtualenv-init -|psub)

  # haskell related
  # ghcup-env
  set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
  test -f /Users/lutz/.ghcup/env ; and set -gx PATH /Users/lutz/.ghcup/bin $PATH
  # cabal bin
  set -gx PATH /Users/lutz/.cabal/bin $PATH

  forgetmenot tuicheck
end
