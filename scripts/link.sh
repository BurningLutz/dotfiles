#!/bin/bash

mkdir -p ~/.config/fish
ln -s $PWD/.config/fish/config.fish $_
mkdir -p ~/.config/fish/functions
ln -s $PWD/.config/fish/functions/fish_prompt.fish $_

mkdir -p ~/.config/nvim
ln -s $PWD/.config/nvim/init.vim $_

ln -s $PWD/.gemrc ~
ln -s $PWD/.gitconfig ~
