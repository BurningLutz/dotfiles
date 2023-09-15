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

-- # EDITOR OPTIONS ############################################################
-- I use dark color scheme.
opt.background    = "dark"

-- hide a buffer instead of unloading it.
opt.hidden        = true

-- treat ambiguous-width chars as single width.
opt.ambiwidth     = "single"

-- make completion for command line mode acts like readline.
opt.wildmode      = { "longest", "full" }
-- my favorite completion style.
opt.completeopt   = { "menu", "longest", "noselect" }

-- 24-bits true color.
opt.termguicolors = true

-- make tab to insert two spaces.
opt.tabstop       = 2
opt.shiftwidth    = 2
opt.expandtab     = true

-- show tab as >-, trailing space as -.
opt.list          = true
opt.listchars     = { tab = ">-", trail = "-", nbsp = "+" }

-- show line number.
opt.number        = true

-- open new pane at right bottom.
opt.splitbelow    = true
opt.splitright    = true

-- swap files cause more trouble.
opt.swapfile      = false
-- reduce updatetime to trigger CursorHold event more frequently.
opt.updatetime    = 100

-- always show sign columns.
opt.signcolumn    = "yes"

-- highlight cursor.
opt.cursorline    = true
opt.cursorcolumn  = true

-- better visual block editing.
opt.mouse         =  ""
opt.virtualedit   = "block"

-- # CONFIG VARIABLES ##########################################################
-- # clipboard
g.clipboard = { name  = "WSL Clipboard"
              , copy  = { ["+"] = "win32yank.exe -i --crlf"
                        }
              , paste = { ["+"] = "win32yank.exe -o --lf"
                        }
              , cache_enabled = 0
              }

-- # disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- # neovim builtins.
g.python_indent            = { disable_parentheses_indenting = true }
g.pyindent_open_paren      = false
g.python_recommended_style = false
g.terminal_color_0         = "#282C34"
g.terminal_color_1         = "#E06C75"
g.terminal_color_2         = "#98C379"
g.terminal_color_3         = "#E5C07B"
g.terminal_color_4         = "#61AFEF"
g.terminal_color_5         = "#C678DD"
g.terminal_color_6         = "#56B6C2"
g.terminal_color_7         = "#DCDFE4"
g.terminal_color_8         = "#5A6374"
g.terminal_color_9         = "#E06C75"
g.terminal_color_10        = "#98C379"
g.terminal_color_11        = "#E5C07B"
g.terminal_color_12        = "#61AFEF"
g.terminal_color_13        = "#C678DD"
g.terminal_color_14        = "#56B6C2"
g.terminal_color_15        = "#DCDFE4"

-- # vim-autoclose
g.AutoClosePreserveDotReg = false

-- # vim-hybrid
-- the dimmer color scheme.
g.hybrid_custom_term_colors = true
g.hybrid_reduced_contrast   = true
cmd "silent! colorscheme hybrid"

-- # vim-gitgutter
-- realtime update
g.gitgutter_terminal_reports_focus = false
cmd "hi! link SignColumn      LineNr"
cmd "hi! link GitGutterAdd    DiagnosticOk"
cmd "hi! link GitGutterChange DiagnosticWarn"
cmd "hi! link GitGutterDelete DiagnosticError"
cmd "hi  link FloatTitle      TelescopeTitle"
cmd "hi  link FloatBorder     TelescopeBorder"

-- # vim-markdown-toc
g.vmt_auto_update_on_save = false
g.vmt_fence_text          = "TOC"
g.vmt_list_item_char      = "-"

-- # editorconfig
g.EditorConfig_exclude_patterns = { "fugitive://.*" }

-- # telescope
cmd "hi link TelescopeMatching Search"
vim.api.nvim_create_autocmd({ "User" }, {
  pattern  = "TelescopePreviewerLoaded"
, callback = function ()
               vim.wo.wrap = true
             end
})

-- # tree-sitter highlights
cmd "hi link @text.diff.delete diffRemoved"
cmd "hi link @text.diff.add    diffAdded"
cmd "hi @text.emphasis cterm=italic gui=italic"
cmd "hi @text.strong   cterm=bold   gui=bold"

-- # lsp highlights
cmd "hi link LspSignatureActiveParameter PmenuSel"

-- # nvim-tree
api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- # KEYMAPS ###################################################################
map { { "n", "o" }, "(", "[(" }
map { { "n", "o" }, ")", "])" }
map { "", "<A-n>", ":NvimTreeToggle<CR>" }
-- sub-word movements.
map { "", "<A-w>", "<Plug>CamelCaseMotion_w" }
map { "", "<A-b>", "<Plug>CamelCaseMotion_b" }
map { "", "<A-e>", "<Plug>CamelCaseMotion_e" }
-- tab managements.
map { "", "<S-A-h>", ":tabprevious<CR>" }
map { "", "<S-A-l>", ":tabnext<CR>" }
map { "", "<A-t>"  , ":tabnew<CR>" }
map { "", "<S-A-w>", ":tabclose<CR>" }
-- buffer switching.
map { "", "<A-h>", ":bprevious<CR>" }
map { "", "<A-l>", ":bnext<CR>" }
-- pane switching.
map { "", "<C-h>", "<C-w>h" }
map { "", "<C-l>", "<C-w>l" }
-- lists and lsp.
map { "n", "<C-A-p>", ":Telescope session-lens<CR>" }
map { "n", "<C-p>"  , function () require "telescope.builtin".find_files { hidden = true } end }
map { "n", "<S-A-p>", function ()
                        require "telescope.builtin".live_grep
                        { additional_args = function () return { "--hidden" } end
                        }
                      end
    }
map { "n", "<A-a>", vim.lsp.buf.code_action }
map { "n", "<A-r>", function ()
                      local opts = require "telescope.themes".get_cursor
                                   { borderchars         = { prompt  = { "─", "│", " ", "│", "┌", "┐", " ", " " }
                                                           , results = { "─", "│", "─", "│", "├", "┤", "┘", "└" }
                                                           , preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
                                                           }
                                   , layout_config       = { width   = 120
                                                           , height  = 15
                                                           }
                                   , show_line           = false
                                   , include_declaration = false
                                   }
                      require "telescope.builtin".lsp_references(opts)
                    end
    }
map { "n", "<A-)>", vim.diagnostic.goto_next }
map { "n", "<A-(>", vim.diagnostic.goto_prev }
map { "n", "K", vim.lsp.buf.hover }
map { { "n", "i" }, "<C-k>", vim.lsp.buf.signature_help }
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

-- # COMMANDS ##################################################################
cmd "com! Rename lua vim.lsp.buf.rename()"
