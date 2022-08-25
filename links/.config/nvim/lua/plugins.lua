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
  -- Jenkinsfile syntax
  use "martinda/Jenkinsfile-vim-syntax"
  -- basis <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  -- web related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  -- Zen!
  use "mattn/emmet-vim"

  -- the order here is IMPORTANT
  -- js syntax highlight
  use "pangloss/vim-javascript"
  -- Extend js highlighter with jsx
  use "MaxMEllon/vim-jsx-pretty"

  use "leafgarland/typescript-vim"
  use "peitalin/vim-jsx-typescript"

  -- Generate jsdoc
  use "heavenshell/vim-jsdoc"
  -- GFM syntax highlight
  use "rhysd/vim-gfm-syntax"
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
  -- User defined textobj support and text object for xml/html attrs
  use "kana/vim-textobj-user"
  use "inside/vim-textobj-jsxattr"
  -- text object for functions
  use "kana/vim-textobj-function"
  use "thinca/vim-textobj-function-javascript"
  -- vue syntax highlight
  use "posva/vim-vue"
  -- web related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  -- fish related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  use "dag/vim-fish"
  -- fish related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  -- python related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  use "bps/vim-textobj-python"
  use "michaeljsmith/vim-indent-object"
  -- python related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  -- purescript related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  use "purescript-contrib/purescript-vim"
  use "vmchale/dhall-vim"
  -- purescript related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  -- haskell related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  use "neovimhaskell/haskell-vim"
  -- haskell related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  use "chr4/nginx.vim"

  use "lifepillar/pgsql.vim"

  -- editorconfig
  use "editorconfig/editorconfig-vim"

  -- db
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"
end)
