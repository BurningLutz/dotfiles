if status --is-login
  # my default editor is neovim
  set -x EDITOR nvim

  # add yarn global bin path
  set -x PATH (yarn global bin) $PATH

  # set fish_ambiguous_width to 2
  set -x fish_ambiguous_width 2

  # autoload rbenv
  source (rbenv init -|psub)
end

if status --is-interactive
  # enhance ls
  alias ll="ls -lhAFG"

  alias vim=nvim

  # pyenv and pyenv virtualenv related
  source (pyenv init -|psub)
  source (pyenv virtualenv-init -|psub)
end
