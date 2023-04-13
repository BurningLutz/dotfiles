# neovim files and packer.nvim
rm -rf ~/.local/share/nvim/site/pack/packer
rm -rf ~/.config/nvim/plugin/packer_compiled.lua

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim -c "autocmd User PackerComplete quitall" -c PackerSync
