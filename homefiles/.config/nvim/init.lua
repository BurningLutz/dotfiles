-- # CONFIG PRIMITIVES ########################################################
local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local g   = vim.g

-- # ESSENTIAL INITS ##########################################################
-- erase LD_LIBRARY_PATH ASAP to ensure shell commands and terminal is not
-- affected
cmd "unlet $LD_LIBRARY_PATH"

-- # UTILS ####################################################################
local function map(args)
  local mode, lhs, rhs = unpack(args)
  args[1] = nil
  args[2] = nil
  args[3] = nil

  vim.keymap.set(mode, lhs, rhs, args)
end

local function tmcursor(w, h)
  return require "telescope.themes".get_cursor
  { borderchars =
    { prompt  = { "─", "│", " ", "│", "┌", "┐", " ", " " }
    , results = { "─", "│", "─", "│", "├", "┤", "┘", "└" }
    , preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    }
  , layout_config =
    { width  = w or 120
    , height = h or 20
    }
  , show_line = false
  , include_declaration = false
  }
end

-- # modified from https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  cmd.cd(data.file)

  -- open the tree
  require "nvim-tree.api".tree.open()
end

-- # PLUGINS ###################################################################
vim.opt.rtp:prepend "~/.local/share/nvim/lazy/lazy.nvim"

require "lazy".setup "plugins"

-- # LUA API EDITOR CONFIG #####################################################
-- diagnostics
vim.diagnostic.config
{ virtual_text = true
}

-- common lsp config
vim.lsp.config("*", {
  capabilities = vim.tbl_deep_extend(
    "force"
  , vim.lsp.protocol.make_client_capabilities()
  , require "cmp_nvim_lsp".default_capabilities()
  )
})

-- auto enabled lsp servers.
vim.lsp.enable
{ "clangd"
, "gopls"
, "hls"
, "lua_ls"
, "pyright"
, "rust_analyzer"
, "ts_ls"
}

-- # EDITOR OPTIONS ############################################################
-- I use dark color scheme.
opt.background     = "dark"

-- hide a buffer instead of unloading it.
opt.hidden         = true

-- treat ambiguous-width chars as single width.
opt.ambiwidth      = "single"

-- make completion for command line mode acts like readline.
opt.wildmode       = { "longest", "full" }
-- my favorite completion style.
opt.completeopt    = { "menu", "longest", "noselect" }

-- 24-bits true color.
opt.termguicolors  = true

-- make tab to insert two spaces.
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.expandtab      = true

-- show tab as >-, trailing space as -.
opt.list           = true
opt.listchars      = { tab = ">-", trail = "-", nbsp = "+" }

-- show line number.
opt.number         = true

-- open new pane at right bottom.
opt.splitbelow     = true
opt.splitright     = true

-- swap files cause more trouble.
opt.swapfile       = false
-- reduce updatetime to trigger CursorHold event more frequently.
opt.updatetime     = 100

-- always show sign columns.
opt.signcolumn     = "yes"

-- highlight cursor.
opt.cursorline     = true
opt.cursorcolumn   = true

-- better visual block editing.
opt.mouse          = ""
opt.virtualedit    = "block"

-- session options for auto session.
opt.sessionoptions = { "blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize", "terminal", "localoptions" }

-- # CONFIG VARIABLES ##########################################################
-- # clipboard
g.clipboard =
{ name = "WSL Clipboard"
, copy =
  { ["+"] = "powershell.exe -c $input | set-clipboard"
  , ["*"] = "powershell.exe -c $input | set-clipboard"
  }
, paste =
  { ["+"] = 'powershell.exe -c [Console]::Out.Write($(get-clipboard -raw).replace("`r", ""))'
  , ["*"] = 'powershell.exe -c [Console]::Out.Write($(get-clipboard -raw).replace("`r", ""))'
  }
, cache_enabled = 0
}

-- # disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- # neovim builtins.
g.python_indent = { disable_parentheses_indenting = true }
g.pyindent_open_paren = false
g.python_recommended_style = false

-- # vim-autoclose
g.AutoClosePreserveDotReg = false

-- # hybrid.nvim
cmd "silent! colorscheme hybrid"

-- # vim-gitgutter
-- realtime update
g.gitgutter_terminal_reports_focus = false

-- # vim-markdown-toc
g.vmt_auto_update_on_save = false
g.vmt_fence_text = "TOC"
g.vmt_list_item_char = "-"

-- # editorconfig
g.EditorConfig_exclude_patterns = { "fugitive://.*" }

-- # telescope
api.nvim_create_autocmd(
  { "User" }
, { pattern  = "TelescopePreviewerLoaded"
  , callback = function () vim.wo.wrap = true end
  }
)

-- # nvim-tree
api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- # haskell dump file highlights
cmd "au BufRead *.dump-simpl     set ft=haskell"
cmd "au BufRead *.dump-stg-final set ft=haskell"

-- # lualine
-- lsp progress notification.
api.nvim_create_augroup("lualine_augroup", { clear = true })
api.nvim_create_autocmd(
  "User"
, { group    = "lualine_augroup"
  , pattern  = "LspProgressStatusUpdated"
  , callback = function () require "lualine".refresh() end
  }
)

-- # KEYMAPS ###################################################################
map { { "n", "o" }, "(", "[(" }
map { { "n", "o" }, ")", "])" }
map { "", "<A-n>", ":NvimTreeToggle<CR>" }
-- sub-word movements.
map { "", "<A-w>", "<Plug>CamelCaseMotion_w" }
map { "", "<A-b>", "<Plug>CamelCaseMotion_b" }
map { "", "<A-e>", "<Plug>CamelCaseMotion_e" }
-- tab managements.
map { "", "<A-H>", ":tabprevious<CR>" }
map { "", "<A-L>", ":tabnext<CR>" }
map { "", "<A-t>"  , ":tabnew<CR>" }
map { "", "<A-W>", ":tabclose<CR>" }
-- buffer switching.
map { "", "<A-h>", ":bprevious<CR>" }
map { "", "<A-l>", ":bnext<CR>" }
-- pane switching.
map { "", "<C-h>", "<C-w>h" }
map { "", "<C-l>", "<C-w>l" }
-- lists and lsp.
map { "n", "grf", function () require "telescope.builtin".find_files { hidden = true } end }
map { "n", "grg", function () require "telescope.builtin".live_grep  { additional_args = { "--hidden" } } end }
map { "n", "grr", function () require "telescope.builtin".lsp_references(tmcursor()) end }
map { "n", "gri", function () require "telescope.builtin".lsp_implementations(tmcursor()) end }
map { "n", "grd", ":Telescope diagnostics<CR>" }
map { "n", "grs", ":Telescope session-lens<CR>" }
map { "n", "gO", ":Telescope lsp_document_symbols<CR>" }
map { "n", "gQ", vim.lsp.buf.format }
map { "n", "<leader>p", ":TSTextobjectSwapNext @parameter.inner<CR>" }
map { "n", "<leader>P", ":TSTextobjectSwapPrevious @parameter.inner<CR>" }
-- command-line mode readline-style movements.
map { "c", "<C-a>", "<Home>" }
map { "c", "<C-e>", "<End>" }
map { "c", "<C-d>", "<Del>" }
map { "c", "<C-b>", "<Left>" }
map { "c", "<C-f>", "<Right>" }
map { "c", "<A-b>", "<S-Left>" }
map { "c", "<A-f>", "<S-Right>" }
-- python cell execution & ipynb conversion.
map { "n", "<leader>x", function ()
        require "notebook-navigator".run_and_move()
      end
    }
map { "n", "<leader>np", function ()
        if vim.fn.executable("jupytext") == 1 then
          local name = vim.fn.expand("%:r")
          local ext  = vim.fn.expand("%:e")

          if ext == "py" then
            cmd(string.format("!jupytext --from=py:percent --to=ipynb --update --output=%s.ipynb %s.py", name, name))
          elseif ext == "ipynb" then
            cmd(string.format("!jupytext --from=ipynb --to=py:percent --output=%s.py %s.ipynb", name, name))
          end
        else
          vim.print("No jupytext found, ignore.")
        end
      end
    }

-- # COMMANDS ##################################################################
