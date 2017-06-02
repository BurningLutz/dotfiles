# enhance ls
alias ll='ls -laFG'

alias vim=nvim

# my default editor is neovim
export EDITOR=nvim

# export npm global path
export PATH=$HOME/npm-global/bin:$PATH

# load git completion
GIT_COMPLETION_PATH=$HOME/bash_completion.d/git-completion.bash
test -e $GIT_COMPLETION_PATH && source $GIT_COMPLETION_PATH

# should install iterm2_shell_integration first
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
