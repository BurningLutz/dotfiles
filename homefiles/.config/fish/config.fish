if status --is-login
  # integrate nix
  . ~/.nix-profile/etc/profile.d/nix.fish
  # set lang
  set -x LANG en_US.UTF-8
  # my default editor is neovim
  set -x EDITOR nvim
  # set true color
  set -x COLORTERM truecolor
  # set fish_ambiguous_width to 1
  set -x fish_ambiguous_width 1
  # set locale archive for nix
  set -x LOCALE_ARCHIVE /usr/lib/locale/locale-archive
  # cabal config location
  set -x CABAL_CONFIG ~/.config/cabal/config
  # ghcup use XDG
  set -x GHCUP_USE_XDG_DIRS 1
end

if status --is-interactive
  alias ll="ls -lhAF"
  alias vim=nvim
  alias open=wslview

  # erase LD_LIBRARY_PATH anyway to let the shell not be affected by
  # my own nvim wrapper.
  # set -e LD_LIBRARY_PATH

  # It seems that export fish_complete_path when login is not enough,
  # I have to set it every time.
  set fish_complete_path ~/.nix-profile/share/fish/vendor_completions.d $fish_complete_path

  # PATH is reset inside terminal of nix's neovim, and neovim start shell
  # in interactive mode, not login mode, so I need to modify PATH here.
  # .local/bin
  fish_add_path --path ~/.local/bin
  # pyenv
  fish_add_path --path ~/.pyenv/bin
end
