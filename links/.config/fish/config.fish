if status --is-login
  # my default editor is neovim
  set -x EDITOR nvim

  # add yarn global bin path
  set -x PATH (yarn global bin) $PATH

  # autoload rbenv
  source (rbenv init -|psub)
end

if status --is-interactive
  # enhance ls
  alias ll="ls -laFG"

  alias vim=nvim
end
