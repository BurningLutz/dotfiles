# reinstall lazy.nvim
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim/lazy
rm -rf ~/.config/nvim/lazy-lock.json

git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim ~/.local/share/nvim/lazy/lazy.nvim
nvim --headless "+Lazy! sync" +qa
