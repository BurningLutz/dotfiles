# dotfiles

My dot files.

# Prerequisite

- Ubuntu >= 23.10

# Installation

Simply run `setup.sh`. Don't worry, it's idempotent. :tada::tada::tada:

## Optional Steps For Windows

- Replace Windows Terminal config file with `windows/windows-terminal/config.json`.
- Download and use [Nerd Fonts](https://www.nerdfonts.com/font-downloads).
- Move `windows/.wslconfig` into %UserProfile%.
- Move `windows/wsl.conf` into /etc inside WSL.

## Other Scripts

There are some custom scripts specific to different situation(mostly install dependencies or softwares) under the `others` dir, they are not executed by default.

Run them standalone as you need.

# Build Distribution

When you changed homefiles or nix configs, you need to run `build.sh` to take effect.

# Switch Snapshot

When you want to upgrade softwares via nix, simply run `home-manager switch`.
