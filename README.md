# dotfiles

My dot files.

# Prerequisites

Install [Nix](https://nixos.org/download.html).

# General Installation

Simply run `setup.sh`. Don't worry, it's idempotent. :tada::tada::tada:

# Additional Steps For Windows

1. Download and install fonts inside the `windows/fonts` dir.
2. Replace Windows Terminal config file with `windows/windows-terminal/config.json`.
3. Move `windows/.wslconfig` into %UserProfile%.
4. Move `windows/wsl.conf` into /etc inside WSL.

# Language Specific Scripts

There are some installation scripts specific to different languages under the `scripts/lang` dir, they are not executed by default.

Run them standalone as you need.
