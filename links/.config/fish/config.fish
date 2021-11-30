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

  # python
  # pyenv and pyenv virtualenv
  set -gx PYENV_ROOT $HOME/.pyenv
  set -gx PATH $PYENV_ROOT/bin $PATH
  pyenv init --path | source
  # add pyenv completions
  pyenv init - | source

  # haskell
  # ghcup-env
  set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
  test -f $HOME/.ghcup/env ; and set -gx PATH $HOME/.ghcup/bin $PATH
  # cabal bin
  set -gx PATH $HOME/.cabal/bin $PATH

  # javascript/typescript
  # deno
  set -gx DENO_INSTALL $HOME/.deno
  set -gx PATH $DENO_INSTALL/bin $PATH

  # golang
  set -gx PATH /usr/local/go/bin $PATH

  # scala
  set -gx PATH $HOME/Library/Application\ Support/Coursier/bin $PATH

  # llvm
  set -gx PATH /usr/local/opt/llvm/bin $PATH

  # softwares
  if type -q forgetmenot
    forgetmenot check
  end
end
