# enhance ls
alias ll="ls -laFG"

alias vim=nvim

# my default editor is neovim
set -x EDITOR nvim

# add yarn global bin path
set -x PATH (yarn global bin) $PATH

# autoload rbenv
status --is-interactive; and source (rbenv init -|psub)
