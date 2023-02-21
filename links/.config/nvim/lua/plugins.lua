---@diagnostic disable: need-check-nil
require "packer".startup(function (use)
  -- # packer.nvim itself.
  use "wbthomason/packer.nvim"

  -- statusline.
  use { "nvim-lualine/lualine.nvim"
      , config = function ()
                   require "lualine".setup
                   { options = { theme = "OceanicNext" }
                   }
                 end
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
                   , renderer      = { icons = { git_placement = "after" } }
                   , actions       = { open_file = { quit_on_open = true } }
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
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
  use { "hrsh7th/nvim-cmp"
      , config = function ()
                   local cmp     = require "cmp"
                   local compare = require "cmp.config.compare"
                   local map     = cmp.mapping

                   cmp.setup
                   { preselect = cmp.PreselectMode.None
                   , snippet   = { expand = function (args)
                                              vim.fn["vsnip#anonymous"](args.body)
                                            end
                                 }
                   , sorting   = { comparators = { compare.offset
                                                 , compare.exact
                                                 , compare.score
                                                 , compare.recently_used
                                                 , compare.locality
                                                 , compare.sort_text
                                                 , compare.length
                                                 , compare.kind
                                                 , compare.order
                                                 }
                                 }
                   , mapping   = map.preset.insert(
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
                                 , ["<C-x><C-o>"] = map.complete()
                                 }
                                 )
                   , sources   = { { name = "path" }
                                 , { name = "buffer", group_index = 2 }
                                 , { name = "nvim_lsp" }
                                 , { name = "vsnip" }
                                 }
                   }
                 end
      }
  use { "neovim/nvim-lspconfig"
      , config = function ()
                   local caps
                   caps = require "cmp_nvim_lsp".default_capabilities()

                   require "lspconfig".hls.setup
                   { capabilities = caps
                   , settings     = { haskell = { plugin = { ["ghcide-completions"] = { config = { snippetsOn = false
                                                                                                 }
                                                                                      }
                                                           }
                                                }
                                    }
                   }
                   require "lspconfig".pyright.setup
                   { capabilities = caps
                   , settings     = { python = { pythonPath = ".venv/bin/python"
                                               , analysis   = { typeCheckingMode = "off" }
                                               }
                                    }
                   }
                   require "lspconfig".lua_ls.setup
                   { capabilities = caps
                   , settings     = { Lua = { runtime     = { version = "LuaJIT" }
                                            , diagnostics = { globals = { "vim" } }
                                            , workspace   = { library         = vim.api.nvim_get_runtime_file("", true)
                                                            , checkThirdParty = false
                                                            }
                                            , telemetry   = { enable = false }
                                            }
                                    }
                   }
                   require "lspconfig".tsserver.setup
                   { capabilities = caps
                   , cmd          = { "typescript-language-server"
                                    , "--stdio"
                                    , "--tsserver-path"
                                    , os.getenv("HOME").."/.nix-profile/lib/node_modules/typescript/lib"
                                    }
                   }
                   require "lspconfig".gopls.setup
                   { capabilities = caps
                   }
                 end
      }
  -- repeat plugin map.
  use "tpope/vim-repeat"
  -- comment stuffs easily.
  use "tpope/vim-commentary"
  -- auto close pairs.
  use { "windwp/nvim-autopairs"
      , config = function ()
                   require "nvim-autopairs".setup {}
                 end
      }
  -- block-wise alignment.
  use { "BurningLutz/blockalign.nvim"
      , after = "Align"
      }
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
                   { ensure_installed = "all"
                   , sync_install     = true
                   , playground       = { enable = true }
                   , highlight        = { enable = true
                                        , additional_vim_regex_highlighting = false
                                        }
                   , textobjects      = { select = { enable  = true
                                                   , keymaps = { ["af"] = "@function.outer"
                                                               , ["if"] = "@function.inner"
                                                               , ["ac"] = "@class.outer"
                                                               , ["ic"] = "@class.inner"
                                                               }
                                                   }
                                        , swap   = { enable = true
                                                   }
                                        }
                   }
                 end
      }
  use "nvim-treesitter/playground"
  use { "nvim-treesitter/nvim-treesitter-textobjects"
      , after = "nvim-treesitter"
      }
  -- lists.
  use { "nvim-telescope/telescope.nvim"
      , requires = "nvim-lua/plenary.nvim"
      , tag      = "0.1.0"
      , config   = function ()
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
                   end
      }
  use { "nvim-telescope/telescope-fzf-native.nvim"
      , run    = "make"
      , after  = "telescope.nvim"
      , config = function ()
                   require "telescope".load_extension "fzf"
                 end
      }
  -- builtin ui replacement.
  use { "stevearc/dressing.nvim"
      , config = function ()
                   require "dressing".setup
                   { input  = { enabled        = true
                              , default_prompt = "> "
                              , prompt_align   = "center"
                              , anchor         = "NW"
                              , border         = "single"
                              , win_options    = { winblend     = 0
                                                 , winhighlight = "Normal:TelescopePromptNormal"
                                                 }
                              , mappings       = { i = { ["<C-a>"] = "<Home>"
                                                       , ["<C-e>"] = "<End>"
                                                       , ["<C-d>"] = "<Del>"
                                                       , ["<C-b>"] = "<Left>"
                                                       , ["<C-f>"] = "<Right>"
                                                       , ["<A-b>"] = "<S-Left>"
                                                       , ["<A-f>"] = "<S-Right>"
                                                       }
                                                 }
                              , override       = function (conf)
                                                   conf.row = 1

                                                   return conf
                                                 end
                              }
                   , select = { enabled     = true
                              , backend     = { "telescope" }
                              , trim_prompt = false
                              , telescope   = require "telescope.themes".get_cursor { borderchars = { prompt  = { "─", "│", " ", "│", "┌", "┐", " ", " " }
                                                                                                    , results = { "─", "│", "─", "│", "├", "┤", "┘", "└" }
                                                                                                    }
                                                                                    }
                              }
                   }
                 end
      }
end)
