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
          hl.Type = { fg = c.yellow }
          -- the original colors are hard to see, so I revert them.
          hl.TabLine     = { fg = c.bg, bg = c.fg }
          hl.TabLineFill = { fg = c.bg, bg = c.fg }
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
          -- gitsigns inline word diff highlights.
          hl.GitSignsAddInline    = { fg = c.bg, bg = c.green }
          hl.GitSignsChangeInline = { fg = c.bg, bg = c.blue  }
          hl.GitSignsDeleteInline = { fg = c.bg, bg = c.red   }
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
, { "lewis6991/gitsigns.nvim"
  , config = function ()
      require "gitsigns".setup
      { signs_staged_enable = false
      , word_diff = true
      }
    end
  }
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
      local fortune   = require "alpha.fortune"
      local dashboard = require "alpha.themes.dashboard"

      local btns = {}
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
      table.insert(btns, dashboard.button("s", "  Open session", ":Telescope session-lens<CR>"))
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
      , git_use_branch_name = false
      , session_lens =
        { picker_opts = { winblend = 0 }
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
, { "romus204/tree-sitter-manager.nvim"
  , opts =
    { ensure_installed = { "diff" }
    , auto_install = true
    , highlight = true
    }
  }
, { "nvim-treesitter/nvim-treesitter-textobjects"
  , branch = "main"
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
  -- debug adapter.
, { "mfussenegger/nvim-dap"
  , config = function ()
      local dap    = require "dap"
      local mode   = require "dap-mode"
      local keymap =
      { continue          = { "dd", "c" }
      , pause             = "p"
      , set_breakpoint    = "a"
      , toggle_breakpoint = "db"
      , clear_breakpoints = "cb"
      , step_back         = "u"
      , step_into         = "i"
      , step_out          = "o"
      , step_over         = "s"
      , terminate         = "x"
      }

      local function uiconfig(session)
        local cleanup = mode.setup(keymap, session.filetype)

        dap.listeners.before.event_exited.uiconfig = function ()
          cleanup()
          -- return true to remove this listener, so it is one-shot.
          return true
        end
      end

      dap.listeners.before.attach.uiconfig = uiconfig
      dap.listeners.before.launch.uiconfig = uiconfig
    end
  }
, { "igorlfs/nvim-dap-view"
  , dependencies = { "mfussenegger/nvim-dap" }
  , opts = {
      auto_toggle = true
    }
  }
, { "theHamsta/nvim-dap-virtual-text"
  , dependencies = { "mfussenegger/nvim-dap" }
  , opts =
    { virt_text_pos = "eol"
      ---@diagnostic disable-next-line: unused-local
    , display_callback = function (variable, buf, stackframe, node, options)
        return variable.value:gsub("%s+", " ")
      end
    }
  }
}
