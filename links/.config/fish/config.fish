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
end

if status --is-interactive
  # enhance ls
  alias ll="ls -lhAF"

  alias vim=nvim

  # .local/bin
  fish_add_path --path $HOME/.local/bin
end
