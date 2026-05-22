pkgs: with pkgs;
let
  pkgsStable = import <nixosStable> {};
in
[
  micromamba
  pkgsStable.pdm
  pyenv
  pyright
  python313Packages.debugpy
]
