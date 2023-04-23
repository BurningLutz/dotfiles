return
{ -- statusline.
  { "nvim-lualine/lualine.nvim"
  , opts = { options  = { theme   = "OceanicNext"
                        , refresh = { statusline = 100
                                    , tabline    = 100
                                    , winbar     = 100
                                    }
                        }
           , sections = { lualine_c = { "filename"
                                      , { "lsp_progress"
                                        , display_components = { "spinner", { "title", "percentage", "message" } }
                                        , spinner_symbols    = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " }
                                        , timer = { progress_enddelay        = 500
                                                  , spinner                  = 100
                                                  , lsp_client_name_enddelay = 0
                                                  }
                                        }
                                      }
                        }
           }
  }
, "WhoIsSethDaniel/lualine-lsp-progress.nvim"
  -- theme.
, "w0ng/vim-hybrid"
  -- dir tree, bookmarks and more.
, { "nvim-tree/nvim-tree.lua"
  , dependencies = { "nvim-tree/nvim-web-devicons" }
  , opts = { system_open   = { cmd = "wslview" }
           , disable_netrw = true
           , renderer      = { icons = { git_placement = "after" } }
           , actions       = { open_file = { quit_on_open = true } }
           }
  }
  -- show file change inline.
, "airblade/vim-gitgutter"
  -- sub-word movements.
, "bkad/CamelCaseMotion"
  -- Surround selections, stylishly 😎
, { "kylechui/nvim-surround"
  , version = "*" -- Use for stability; omit to use `main` branch for the latest features
  , opts = { indent_lines = false
           }
  }
  -- git wrapper.
, "tpope/vim-fugitive"
  -- 🔗 the fancy start screen for Vim.
, "mhinz/vim-startify"
  -- align something.
, "vim-scripts/Align"
  -- search and replace through the whole project.
, "dyng/ctrlsf.vim"
  -- auto completion.
, "hrsh7th/cmp-path"
, "hrsh7th/cmp-buffer"
, "hrsh7th/cmp-nvim-lsp"
, "hrsh7th/cmp-vsnip"
, "hrsh7th/vim-vsnip"
, { "hrsh7th/nvim-cmp"
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
, { "neovim/nvim-lspconfig"
  , config = function ()
               local lspconfig = require "lspconfig"
               lspconfig.util.default_config = vim.tbl_extend( "force"
                                                             , lspconfig.util.default_config
                                                             , require "cmp_nvim_lsp".default_capabilities()
                                                             )

               lspconfig.hls.setup
               { settings = { haskell = { plugin = { ["ghcide-completions"] = { config = { snippetsOn = false
                                                                                         }
                                                                              }
                                                   }
                                        }
                            }
               }
               lspconfig.pyright.setup
               { settings = { python = { pythonPath = ".venv/bin/python"
                                       , analysis   = { typeCheckingMode      = "off"
                                                      , autoImportCompletions = false
                                                      }
                                       }
                            }
               }
               lspconfig.lua_ls.setup
               { settings = { Lua = { runtime     = { version = "LuaJIT" }
                                    , diagnostics = { globals = { "vim" } }
                                    , workspace   = { library         = vim.api.nvim_get_runtime_file("", true)
                                                    , checkThirdParty = false
                                                    }
                                    , telemetry   = { enable = false }
                                    }
                            }
               }
               lspconfig.tsserver.setup {}
               lspconfig.gopls.setup {}
               lspconfig.jdtls.setup
               { cmd = { "jdt-language-server"
                       , "-configuration"
                       , os.getenv("HOME").."/.cache/jdtls/config"
                       , "-data"
                       , os.getenv("HOME").."/.cache/jdtls/workspace"
                       }
               }
             end
  }
  -- repeat plugin map.
, "tpope/vim-repeat"
  -- comment stuffs easily.
, "tpope/vim-commentary"
  -- auto close pairs.
, "windwp/nvim-autopairs"
  -- block-wise alignment.
, { "BurningLutz/blockalign.nvim"
  , dependencies = { "Align" }
  }
  -- markdown preview.
, { "iamcco/markdown-preview.nvim"
  , build = "cd app && npm install"
  , ft    = { "markdown" }
  , init  = function ()
              vim.g.mkdp_filetypes = { "markdown" }
            end
  }
  -- markdown generate toc.
, { "mzlogin/vim-markdown-toc"
  , ft = { "markdown" }
  }
  -- markdown table mode.
, { "dhruvasagar/vim-table-mode"
  , ft = { "markdown" }
  }
  -- db.
, "tpope/vim-dadbod"
, "kristijanhusak/vim-dadbod-ui"
  -- treesitter, the syntax parser providing highlighting and textobjects.
, { "nvim-treesitter/nvim-treesitter"
  , build  = function ()
               require "nvim-treesitter.install".update { with_sync = true }
             end
  , config = function ()
               require "nvim-treesitter.install".compilers = { os.getenv "NVIM_TREESITTER_COMPILER_PATH" }
               require "nvim-treesitter.configs".setup
               { ensure_installed = { "diff", "markdown", "markdown_inline" }
               , sync_install     = true
               , auto_install     = true
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
, "nvim-treesitter/playground"
, { "nvim-treesitter/nvim-treesitter-textobjects"
  , dependencies = { "nvim-treesitter" }
  }
  -- lists.
, { "nvim-telescope/telescope.nvim"
  , dependencies = { "nvim-lua/plenary.nvim", "telescope-fzf-native.nvim" }
  , version      = "0.1.1"
  , config       = function ()
                     require "telescope".setup
                     { defaults = { scroll_strategy = "limit"
                                  , path_display    = { "shorten" }
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
, { "nvim-telescope/telescope-fzf-native.nvim"
  , build = "make"
  }
  -- builtin ui replacement.
, { "stevearc/dressing.nvim"
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
}
