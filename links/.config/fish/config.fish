if status --is-login
  # my default editor is neovim
  set -x EDITOR nvim

  # set fish_ambiguous_width to 1
  set -x fish_ambiguous_width 1

  # set locale archive for nix
  set -x LOCALE_ARCHIVE /usr/lib/locale/locale-archive
  # set lang
  set -x LANG en_US.UTF-8
end

if status --is-interactive
  # enhance ls
  alias ll="ls -lhAF"

  alias vim=nvim

  # .local/bin
  fish_add_path --path $HOME/.local/bin

  # python
  # pyenv and pyenv virtualenv
  set -x PYENV_ROOT $HOME/.pyenv
  set -x PATH $PYENV_ROOT/bin $PATH
  if type -q pyenv
    pyenv init --path | source
    # add pyenv completions
    pyenv init - | source
  end
  # poetry
  set -gx PATH $HOME/.poetry/bin $PATH

  # haskell
  # ghcup-env
  set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
  test -f $HOME/.ghcup/env ; and set -gx PATH $HOME/.ghcup/bin $PATH
  # cabal bin
  set -gx PATH $HOME/.cabal/bin $PATH
end
