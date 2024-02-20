# dotfiles

My dot files.

# Prerequisite

- Ubuntu >= 23.10

# Installation

Simply run `setup`. Don't worry, it's idempotent. :tada::tada::tada:

> The `setup` inherently invokes `build` & `home-manager switch` to make your dotfiles ready.
> For regular maintenance steps, see [Maintenance](#Maintenance).

## Optional Steps For Windows

- Replace Windows Terminal config file with `windows/windows-terminal/config.json`.
- Download and use [Nerd Fonts](https://www.nerdfonts.com/font-downloads).
- Move `windows/.wslconfig` into %UserProfile%.
- Move `windows/wsl.conf` into /etc inside WSL.

## Other Scripts

There are some custom scripts specific to different situation(mostly install dependencies or softwares) under the `others` dir, they are not executed by default.

Run them standalone as you need.

# Maintenance

The maintenance is basically made up of two steps: `build` & `home-manager switch`.

## Build Distribution

When you change your dotfiles(homefiles, package sets enabled etc.), you need to run `build` to prepare files for home-manager.

## Switch Snapshot

And then you run `home-manager switch` to take effect.

Running `home-manager switch` standalone will also upgrade softwares via nix, do it as you need.

## Package Set Management

As more and more packages were added to `home.nix`, the time of first installation becomes longer and longer.
To mitigate the issue, many packages were splitted outside `home.nix` into separated package sets.

The `pkgset` provides all functions to manage them.

- `pkgset list` lists all selected and built package sets.
- `pkgset include <pkgset>` select the `<pkgset>`.
- `pkgset exclude <pkgset>` exclude the `<pkgset>` from selection.

After you've done the package sets selection, you need to run `build` to take effect.
