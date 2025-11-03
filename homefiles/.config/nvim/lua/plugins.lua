return
{ -- statusline.
  { "nvim-lualine/lualine.nvim"
  , dependencies = { "HoNamDuong/hybrid.nvim" }
  , config = function ()
      -- make hybrid inactive lualine visible.
      local c = require "hybrid.colors".setup()
      local theme = require "lualine.themes.hybrid"
      theme.inactive =
      { a = { fg = c.fg, bg = c.line }
      , b = { fg = c.fg, bg = c.line }
      , c = { fg = c.fg, bg = c.line }
      }

      require "lualine".setup
      { options =
        { theme = theme
        , refresh =
          { statusline = 100
          , tabline    = 100
          , winbar     = 100
          }
          -- alpha is the filetype of start screen.
        , disabled_filetypes = { "alpha" }
        }
      , sections =
        { lualine_c =
          { "filename"
          , function ()
              return require "lsp-progress".progress()
            end
          }
        }
      }
    end
  }
, { "linrongbin16/lsp-progress.nvim"
  , version = "*"
  , config = function ()
      require "lsp-progress".setup {}
    end
  }
  -- theme.
, { "HoNamDuong/hybrid.nvim"
  , config = function ()
      -- first we customize default palette to reduced contrast version.
      local p = require "hybrid.colors".palette
      p.bright_black = "#425059"
      p.black        = "#232c31"
      p.dull_white   = "#6c7a80"

      -- and then setup.
      require "hybrid".setup
      { overrides = function (hl, c)
          -- I like classic Type highlight.
          hl.Type            = { fg = c.yellow }
          -- proper gitgutter highlights.
          hl.GitGutterAdd    = { link = "diffAdded" }
          hl.GitGutterChange = { link = "diffChanged" }
          hl.GitGutterDelete = { link = "diffRemoved" }
          -- the original colors are hard to see, so I revert them.
          hl.TabLine         = { fg = c.bg, bg = c.fg }
          hl.TabLineFill     = { fg = c.bg, bg = c.fg }
          -- classic popups.
          hl.Pmenu           = { fg = c.fg, bg = c.bg_soft }
          hl.PmenuSel        = { fg = c.bg_soft, bg = c.fg }
          hl.PmenuSbar       = { bg = c.fg_soft }
          hl.PmenuThumb      = { bg = c.fg_hard }
          hl.NormalFloat     = { link = "Pmenu" }
          hl.FloatBorder     = { fg = c.float.border, bg = c.bg_soft }
          hl.FloatTitle      = { fg = c.float.title , bg = c.bg_soft }
          hl.TelescopeNormal = { link = "Normal" }
          hl.TelescopeBorder = { link = "TelescopeNormal" }
          hl.TelescopeTitle  = { link = "TelescopeNormal" }
        end
      }
    end
  }
  -- dir tree, bookmarks and more.
, { "nvim-tree/nvim-tree.lua"
  , dependencies = { "nvim-tree/nvim-web-devicons" }
  , version = "*"
  , opts =
    { disable_netrw = true
    , hijack_cursor = true
    , view = { centralize_selection = true }
    , system_open = { cmd = "wslview" }
    , renderer =
      { group_empty = true
      , icons = { git_placement = "after" }
      , indent_width = 1
      }
    , actions =
      { open_file = { quit_on_open = true }
      }
    , filters = { custom = { "^\\.git$" } }
    , live_filter = { always_show_folders = false }
    , sync_root_with_cwd = true
    , update_focused_file = { enable = true }
    }
  }
  -- show file change inline.
, "airblade/vim-gitgutter"
  -- sub-word movements.
, "bkad/CamelCaseMotion"
  -- Surround selections, stylishly 😎
, { "kylechui/nvim-surround"
  , version = "*" -- Use for stability; omit to use `main` branch for the latest features
  , opts = { indent_lines = false }
  }
  -- git wrapper.
, "tpope/vim-fugitive"
  -- highly customizable start screen.
, { "goolord/alpha-nvim"
  , dependencies = { "nvim-tree/nvim-web-devicons" }
  , config = function ()
      local sessutil  = require "auto-session"
      local sesslib   = require "auto-session.lib"
      local fortune   = require "alpha.fortune"
      local dashboard = require "alpha.themes.dashboard"

      local session_files = vim.fn.readdir(sessutil.get_root_dir())
      local btns = {}

      table.insert(
        btns
      , { type = "text", val = "Sessions"
        , opts =
          { hl = "Constant"
          , position = "center"
          }
        }
      )
      for n, sess in ipairs({ unpack(session_files, 1, 3) }) do
        local name = string.match(sesslib.unescape_session_name(sess), "(.*)%.vim$")
        local cmd = ":lua require 'auto-session'.RestoreSession('"..name.."')<CR>"
        local btn = dashboard.button(tostring(n), "  "..name, cmd)

        table.insert(btns, btn)
      end

      table.insert(btns, { type = "padding", val = 1 })
      table.insert(
        btns
      , { type = "text", val = "Action"
        , opts =
          { hl = "Constant"
          , position = "center"
          }
        }
      )
      table.insert(btns, dashboard.button("e", "  New file", ":ene<CR>"))
      table.insert(btns, dashboard.button("p", "  Open session", ":Telescope session-lens<CR>"))
      table.insert(btns, dashboard.button("q", "󰿅  Quit", ":qa!<CR>"))

      dashboard.section.buttons.val = btns

      dashboard.section.footer.val = fortune()
      dashboard.section.footer.opts.hl = "String"

      require "alpha".setup(dashboard.config)
    end
  }
  -- session management.
, { "rmagatti/auto-session"
  , config = function ()
      local ignored_filetypes = { "gitcommit", "gitrebase", "fugitive", "NvimTree" }

      require "auto-session".setup
      { auto_restore = false
      , auto_create  = false
      , use_git_branch = false
      -- it's critical to set `cwd_change_handling` to nil to work-around a
      -- "session cleared unexpectedly" issue.
      -- see https://github.com/rmagatti/auto-session/issues/205
      , cwd_change_handling = nil
      , session_lens =
        { theme_conf  = { winblend = 0 }
        , borderchars =
          { prompt  = { "─", "│", " ", "│", "┌", "┐", "┘", "└" }
          , results = { "─", "│", "─", "│", "├", "┤", "┘", "└" }
          }
        }
      -- hooks
      , pre_save_cmds =
        { function ()
            -- delete buffers that should not be saved into a session.
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

              if vim.api.nvim_buf_is_valid(buf) and vim.tbl_contains(ignored_filetypes, buf_ft) then
                vim.api.nvim_buf_delete(buf, { force = true })
              end
            end
          end
        }
      }
    end
  }
  -- align something.
, "vim-scripts/Align"
  -- search and replace through the whole project.
, "dyng/ctrlsf.vim"
  -- auto completion.
, { "hrsh7th/nvim-cmp"
  , dependencies =
    { "hrsh7th/cmp-nvim-lsp"
    , "hrsh7th/cmp-path"
    , "hrsh7th/cmp-buffer"
    }
  , config = function ()
      local compare = require "cmp.config.compare"
      local cmp = require "cmp"
      local map = cmp.mapping

      cmp.setup
      { preselect = cmp.PreselectMode.None
      , snippet =
        { expand = function (args)
            vim.snippet.expand(args.body)
          end
        }
      , sorting =
        { comparators =
          { compare.exact
          , compare.score
          , compare.kind
          , compare.sort_text
          }
        }
      , mapping = map.preset.insert
        { ["<CR>"]  = map.confirm()
        , ["<C-f>"] = map.scroll_docs(4)
        , ["<C-b>"] = map.scroll_docs(-4)
        , ["<Tab>"] = map(
            function (fallback)
              if cmp.visible() then
                cmp.select_next_item { behavior = cmp.SelectBehavior }
              else
                fallback()
              end
            end
          , { "i" }
          )
        , ["<S-Tab>"] = map(
            function (fallback)
              if cmp.visible() then
                cmp.select_prev_item { behavior = cmp.SelectBehavior }
              else
                fallback()
              end
            end
          , { "i" }
          )
        , ["<C-x><C-o>"] = map.complete()
        }
      , sources =
        { { name = "nvim_lsp" }
        , { name = "buffer" }
        , { name = "path" }
        }
      }
    end
  }
, "neovim/nvim-lspconfig"
  -- java language support.
  -- currently the support is very very basic, it uses java toolchain from PATH
  -- and not yet fine tuned for UX.
, "mfussenegger/nvim-jdtls"
  -- repeat plugin map.
, "tpope/vim-repeat"
  -- comment stuffs easily.
, "tpope/vim-commentary"
  -- auto close pairs.
, { "windwp/nvim-autopairs"
  , opts = {}
  }
  -- block-wise alignment.
, { "BurningLutz/blockalign.nvim"
  , dependencies = { "Align" }
  }
  -- markdown preview.
, { "iamcco/markdown-preview.nvim"
  , build = "cd app && yarn install"
  , ft = { "markdown" }
  , init = function ()
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
  , build  = ":TSUpdate"
  , config = function ()
      require "nvim-treesitter.install".compilers = { os.getenv "NVIM_TREESITTER_COMPILER_PATH" }
      require "nvim-treesitter.configs".setup
      ---@diagnostic disable-next-line: missing-fields
      { ensure_installed = { "diff" }
      , sync_install = true
      , auto_install = true
      , highlight =
        { enable = true
        , additional_vim_regex_highlighting = false
        }
      , textobjects =
        { select =
          { enable = true
          , keymaps =
            { ["af"] = "@function.outer"
            , ["if"] = "@function.inner"
            , ["ac"] = "@class.outer"
            , ["ic"] = "@class.inner"
            }
          }
        , swap = { enable = true }
        }
      }
    end
  }
, { "nvim-treesitter/nvim-treesitter-textobjects"
  , dependencies = { "nvim-treesitter" }
  }
  -- lists.
, { "nvim-telescope/telescope.nvim"
  , dependencies =
    { "nvim-lua/plenary.nvim"
    , "rmagatti/auto-session"
    , "telescope-fzf-native.nvim"
    }
  , version = "*"
  , config = function ()
      require "telescope".setup
      { defaults =
        { scroll_strategy = "limit"
        , wrap_results = true
        , path_display = { "smart" }
        , borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
        , mappings =
          { i =
            { ["<ESC>"] = "close"
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
      require "telescope".load_extension "session-lens"
    end
  }
, { "nvim-telescope/telescope-fzf-native.nvim"
  , build = "make"
  }
  -- builtin ui replacement.
, { "stevearc/dressing.nvim"
  , config = function ()
      local cursor_theme = require "telescope.themes".get_cursor
      { borderchars =
        { prompt  = { "─", "│", " ", "│", "┌", "┐", " ", " " }
        , results = { "─", "│", "─", "│", "├", "┤", "┘", "└" }
        }
      }

      require "dressing".setup
      { input =
        { enabled = true
        , default_prompt = "> "
        , prompt_align = "center"
        , border = "single"
        , win_options =
          { winblend = 0
          , winhighlight = table.concat(
              { "Normal:TelescopePromptNormal"
              , "FloatBorder:TelescopeBorder"
              , "FloatTitle:TelescopeTitle"
              }
            , ","
            )
          }
        , mappings =
          { i =
            { ["<C-a>"] = "<Home>"
            , ["<C-e>"] = "<End>"
            , ["<C-d>"] = "<Del>"
            , ["<C-b>"] = "<Left>"
            , ["<C-f>"] = "<Right>"
            , ["<A-b>"] = "<S-Left>"
            , ["<A-f>"] = "<S-Right>"
            }
          }
        , override = function (conf) conf.row = 1 return conf end
        }
      , select =
        { enabled = true
        , backend = { "telescope" }
        , trim_prompt = false
        , telescope = cursor_theme
        }
      }
    end
  }
, { "GCBallesteros/NotebookNavigator.nvim"
  , event = "VeryLazy"
  , opts = { syntax_highlight = true }
  }
, { "hkupty/iron.nvim"
  , event  = "VeryLazy"
  , config = function ()
      require "iron.core".setup
      { config =
        { repl_open_cmd  = "leftabove vsplit"
        , highlight_last = false
        }
      }
    end
  }
  -- debug adapter.
, { "mfussenegger/nvim-dap"
  , version = "*"
  }
, { "rcarriga/nvim-dap-ui"
  , version = "*"
  , dependencies =
    { "mfussenegger/nvim-dap"
    , "nvim-neotest/nvim-nio"
    , "nvim-tree/nvim-tree.lua"
    }
  , config = function ()
      local dap    = require "dap"
      local dapui  = require "dapui"
      local dapmap = require "dapmap"
      local nvtapi = require "nvim-tree.api"
      local keymap =
      { continue          = { "dd", "c" }
      , pause             = "p"
      , toggle_breakpoint = { "db", "a" }
      , clear_breakpoints = "cb"
      , step_back         = "u"
      , step_into         = "i"
      , step_out          = "o"
      , step_over         = "s"
      , terminate         = "x"
      }

      -- a trick to resize dapui.
      -- needs to subscribe here, not inside `setupdap` cuz there is no cleanup
      -- mechanism in NvimTree events api.
      nvtapi.events.subscribe(nvtapi.events.Event.TreeClose, function ()
        if dap.session() then
          -- the deferring here is crucial, TreeClose is triggered before the
          -- window actually gets closed.
          vim.defer_fn(function ()
            dapui.open({ reset = true })
          end, 0)
        end
      end)

      local function setupdap()
        dapui.open()
        local cleanup = dapmap.setup(keymap)

        dap.listeners.before.event_exited.dapui_config = function ()
          dapui.close()
          cleanup()
        end
      end

      dapui.setup
      ---@diagnostic disable-next-line: missing-fields
      { controls = { enabled = false }
      , expand_lines = false
      }

      dap.listeners.before.attach.dapui_config = setupdap
      dap.listeners.before.launch.dapui_config = setupdap
    end
  }
}
