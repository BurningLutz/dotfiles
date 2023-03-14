# dotfiles

My dot files.

# Prerequisites

Install [Nix](https://nixos.org/download.html).

# General Installation

Simply run `setup.sh`. Don't worry, it's idempotent. :tada::tada::tada:

# Optional Steps For Windows

- Replace Windows Terminal config file with `windows/windows-terminal/config.json`.
- Download and install fonts in the following links, which are all from [nerd-font](https://github.com/ryanoasis/nerd-fonts).
  - [regular](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CodeNewRoman/Regular/complete/Code%20New%20Roman%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.otf)
  - [bold](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CodeNewRoman/Bold/complete/Code%20New%20Roman%20Bold%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.otf)
  - [Italic](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CodeNewRoman/Italic/complete/Code%20New%20Roman%20Italic%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.otf)
- Move `windows/.wslconfig` into %UserProfile%.
- Move `windows/wsl.conf` into /etc inside WSL.

# Language Specific Scripts

There are some installation scripts specific to different languages under the `scripts/lang` dir, they are not executed by default.

Run them standalone as you need.
