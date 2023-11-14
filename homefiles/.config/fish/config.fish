if status --is-login
  # integrate nix
  . ~/.nix-profile/etc/profile.d/nix.fish
  # set lang
  set -x LANG en_US.UTF-8
  # my default editor is neovim
  set -x EDITOR nvim
  # neovim as manpager
  set -x MANPAGER "nvim +Man!"
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
  # make go store its workspace files into ~/.local/state
  set -x GOPATH ~/.local/state/go
  # micromamba managed manually
  set -x MAMBA_EXE ~/.local/bin/micromamba
  set -x MAMBA_ROOT_PREFIX ~/.local/state/micromamba
  $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
end

if status --is-interactive
  alias ll="ls -lhAF"
  alias vim=nvim
  alias open=wslview

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
