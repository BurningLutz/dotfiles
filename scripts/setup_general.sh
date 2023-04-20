# cleanup packer stuffs
rm -rf ~/.local/share/nvim/site/pack/packer
rm -rf ~/.config/nvim/plugin/packer_compiled.lua

# reinstall lazy.nvim
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim/lazy
rm -rf ~/.config/nvim/lazy-lock.json

git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim ~/.local/share/nvim/lazy/lazy.nvim
nvim --headless "+Lazy! sync" +qa

# git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# nvim -c "autocmd User PackerComplete quitall" -c PackerSync
