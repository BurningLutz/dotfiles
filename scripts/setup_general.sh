# neovim with packer.nvim
export PACKER_PATH=~/.local/share/nvim/site/pack/packer

# reinstall packer.nvim and all plugins
rm -rf $PACKER_PATH

git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_PATH/start/packer.nvim
nvim -c "autocmd User PackerComplete quitall" -c PackerSync
