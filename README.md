# dotfiles

My dot files.

# Prerequisites

Install [Nix](https://nixos.org/download.html).

# General Installation

Simply run `setup.sh`. Don't worry, it's idempotent. :tada::tada::tada:

# Optional Steps For Windows

- Replace Windows Terminal config file with `windows/windows-terminal/config.json`.
- Download and use [Nerd Fonts](https://www.nerdfonts.com/font-downloads).
- Move `windows/.wslconfig` into %UserProfile%.
- Move `windows/wsl.conf` into /etc inside WSL.

# Language Specific Scripts

There are some installation scripts specific to different languages under the `scripts/lang` dir, they are not executed by default.

Run them standalone as you need.
