return require("packer").startup(function (use)
  -- packer.nvim itself
  use "wbthomason/packer.nvim"

  -- basis >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  -- Useful toolbar
  use "liuchengxu/eleline.vim"
  -- theme
  use "w0ng/vim-hybrid"
  -- Dir tree, bookmarks and more
  use "scrooloose/nerdtree"
  -- Show file change inline
  use "airblade/vim-gitgutter"
  -- Sub-word movements
  use "bkad/CamelCaseMotion"
  -- Surround.vim is all about "surroundings": parentheses, brackets, quotes,
  -- XML tags, and more. The plugin provides mappings to easily delete,
  -- change and add such surroundings in pairs.
  use "tpope/vim-surround"
  -- git wrapper
  use "tpope/vim-fugitive"
  -- 🔗 The fancy start screen for Vim.
  use "mhinz/vim-startify"
  -- Align something
  use "vim-scripts/Align"
  -- Search and replace through the whole project
  use "dyng/ctrlsf.vim"
  -- auto-complete
  use { "neoclide/coc.nvim"
      , tag = "v0.0.81"
      }
  -- repeat plugin map
  use "tpope/vim-repeat"
  -- comment stuffs easily
  use "tpope/vim-commentary"
  -- auto close pairs
  use "BurningLutz/vim-autoclose"
  -- block-wise alignment
  use "BurningLutz/blockalign.nvim"
  -- basis <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  -- web related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  -- markdown preview
  use { "iamcco/markdown-preview.nvim"
      , run   = "cd app && npm install"
      , ft    = { "markdown" }
      , setup = function ()
                  vim.g.mkdp_filetypes = { "markdown" }
                end
      }
  -- markdown generate toc
  use "mzlogin/vim-markdown-toc"
  -- table mode
  use "dhruvasagar/vim-table-mode"
  -- web related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  -- editorconfig
  use "editorconfig/editorconfig-vim"

  -- db
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"

  use { "nvim-treesitter/nvim-treesitter"
      , run = function ()
                require"nvim-treesitter.install".update { with_sync = true }
              end
      }
  use "nvim-treesitter/nvim-treesitter-textobjects"
end)
