---@diagnostic disable: need-check-nil
require "packer".startup(function (use)
  -- # packer.nvim itself.
  use "wbthomason/packer.nvim"

  -- toolbar.
  use { "liuchengxu/eleline.vim"
      , requires = "nvim-lua/lsp-status.nvim"
      }
  -- theme.
  use "w0ng/vim-hybrid"
  -- dir tree, bookmarks and more.
  use { "kyazdani42/nvim-tree.lua"
      , requires = "kyazdani42/nvim-web-devicons"
      , tag    = "nightly"
      , config = function ()
                   require "nvim-tree".setup
                   { system_open   = { cmd = "wslview" }
                   , disable_netrw = true
                   }
                 end
      }
  -- show file change inline.
  use "airblade/vim-gitgutter"
  -- sub-word movements.
  use "bkad/CamelCaseMotion"
  -- Surround.vim is all about "surroundings": parentheses, brackets, quotes,
  -- XML tags, and more. The plugin provides mappings to easily delete,
  -- change and add such surroundings in pairs.
  use "tpope/vim-surround"
  -- git wrapper.
  use "tpope/vim-fugitive"
  -- 🔗 the fancy start screen for Vim.
  use "mhinz/vim-startify"
  -- align something.
  use "vim-scripts/Align"
  -- search and replace through the whole project.
  use "dyng/ctrlsf.vim"
  -- auto completion.
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use { "hrsh7th/nvim-cmp"
      , config = function ()
                   local luasnip = require "luasnip"
                   local cmp     = require "cmp"
                   local map     = cmp.mapping

                   cmp.setup
                   { snippet = { expand = function (args)
                                            luasnip.lsp_expand(args.body)
                                          end
                               }
                   , mapping = map.preset.insert(
                               { ["<C-b>"]      = map.scroll_docs(-4)
                               , ["<C-f>"]      = map.scroll_docs(4)
                               , ["<CR>"]       = map.confirm()
                               , ["<Tab>"]      = map( function(fallback)
                                                         if cmp.visible() then
                                                           cmp.select_next_item({ behavior = cmp.SelectBehavior })
                                                         else
                                                           fallback()
                                                         end
                                                       end
                                                     , { "i" }
                                                     )
                               , ["<S-Tab>"]    = map( function(fallback)
                                                         if cmp.visible() then
                                                           cmp.select_prev_item({ behavior = cmp.SelectBehavior })
                                                         else
                                                           fallback()
                                                         end
                                                       end
                                                     , { "i" }
                                                     )
                               , ["<C-j>"]      = map( function (fallback)
                                                         if luasnip.expand_or_jumpable() then
                                                           luasnip.expand_or_jump()
                                                         else
                                                           fallback()
                                                         end
                                                       end
                                                     , { "s" }
                                                     )
                               , ["<C-k>"]      = map( function (fallback)
                                                         if luasnip.jumpable(-1) then
                                                           luasnip.jump(-1)
                                                         else
                                                           fallback()
                                                         end
                                                       end
                                                     , { "s" }
                                                     )
                               , ["<C-x><C-o>"] = map.complete()
                               }
                               )
                   , sources = { { name = "path" }
                               , { name = "buffer" }
                               , { name = "luasnip" }
                               , { name = "nvim_lsp" }
                               , { name = "nvim_lsp_signature_help" }
                               }
                   }
                 end
      }
  use { "neovim/nvim-lspconfig"
      , config = function ()
                   local caps
                   caps = vim.lsp.protocol.make_client_capabilities()
                   caps = require "cmp_nvim_lsp".update_capabilities(caps)

                   require "lspconfig".hls.setup
                   { capabilities = caps }
                   require "lspconfig".pyright.setup
                   { capabilities = caps
                   , settings     = { python = { pythonPath = ".venv/bin/python"
                                               , analysis   = { typeCheckingMode = "off" }
                                               }
                                    }
                   }
                   require "lspconfig".sumneko_lua.setup
                   { capabilities = caps
                   , settings     = { Lua = { runtime     = { version = "LuaJIT" }
                                            , diagnostics = { globals = { "vim" } }
                                            , workspace   = { library = vim.api.nvim_get_runtime_file("", true) }
                                            , telemetry   = { enable = false }
                                            }
                                    }
                   }
                   require "lspconfig".tsserver.setup
                   { capabilities        = caps
                   , cmd                 = { "typescript-language-server"
                                           , "--stdio"
                                           , "--tsserver-path"
                                           , os.getenv("HOME").."/.nix-profile/lib/node_modules/typescript/lib"
                                           }
                   , single_file_support = true
                   }
                 end
      }
  -- repeat plugin map.
  use "tpope/vim-repeat"
  -- comment stuffs easily.
  use "tpope/vim-commentary"
  -- auto close pairs.
  use "BurningLutz/vim-autoclose"
  -- block-wise alignment.
  use "BurningLutz/blockalign.nvim"
  -- markdown preview.
  use { "iamcco/markdown-preview.nvim"
      , run   = "cd app && npm install"
      , ft    = { "markdown" }
      , setup = function ()
                  vim.g.mkdp_filetypes = { "markdown" }
                end
      }
  -- markdown generate toc.
  use { "mzlogin/vim-markdown-toc"
      , ft = { "markdown" }
      }
  -- markdown table mode.
  use { "dhruvasagar/vim-table-mode"
      , ft = { "markdown" }
      }
  -- editorconfig.
  use "editorconfig/editorconfig-vim"
  -- db.
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"
  -- treesitter, the syntax parser providing highlighting and textobjects.
  use { "nvim-treesitter/nvim-treesitter"
      , run    = function ()
                   require "nvim-treesitter.install".update { with_sync = true }
                 end
      , config = function ()
                   require "nvim-treesitter.configs".setup
                   { auto_install = true
                   , highlight    = { enable = true
                                    , additional_vim_regex_highlighting = false
                                    }
                   , textobjects  = { select = { enable  = true
                                               , keymaps = { ["af"] = "@function.outer"
                                                           , ["if"] = "@function.inner"
                                                           , ["ac"] = "@class.outer"
                                                           , ["ic"] = "@class.inner"
                                                           }
                                               }
                                    , swap   = { enable        = true
                                               , swap_next     = { ["<leader>p"] = { "@parameter.inner" }
                                                                 }
                                               , swap_previous = { ["<leader>P"] = { "@parameter.inner" }
                                                                 }
                                               }
                                    }
                   , rainbow      = { enable = true }
                   }
                 end
      }
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "p00f/nvim-ts-rainbow"
  -- lists.
  use { "nvim-telescope/telescope.nvim"
      , requires = "nvim-lua/plenary.nvim"
      , tag    = "0.1.0"
      , config = function ()
                   require "telescope".setup
                   { defaults = { scroll_strategy = "limit"
                                , borderchars     = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
                                , mappings        = { i = { ["<ESC>"] = "close"
                                                          , ["<C-a>"] = { "<Home>"   , type = "command" }
                                                          , ["<C-e>"] = { "<End>"    , type = "command" }
                                                          , ["<C-d>"] = { "<Del>"    , type = "command" }
                                                          , ["<C-b>"] = { "<Left>"   , type = "command" }
                                                          , ["<C-f>"] = { "<Right>"  , type = "command" }
                                                          , ["<C-u>"] = { "<C-u>"    , type = "command" }
                                                          , ["<A-b>"] = { "<S-Left>" , type = "command" }
                                                          , ["<A-f>"] = { "<S-Right>", type = "command" }
                                                          }
                                                    }
                                }
                   }
                   require "telescope".load_extension "fzf"
                 end
      }
  use { "nvim-telescope/telescope-fzf-native.nvim"
      , run = "make"
      }
end)
