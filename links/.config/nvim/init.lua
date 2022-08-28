local opt = vim.opt
local cmd = vim.cmd
local fn  = vim.fn
local g   = vim.g

local function map(args)
  local mode, lhs, rhs = unpack(args)
  args[1] = nil
  args[2] = nil
  args[3] = nil

  vim.keymap.set(mode, lhs, rhs, args)
end


-- options
opt.hidden        = true
-- treat ambiguous-width chars as single width.
opt.ambiwidth     = "single"
-- make completion for command line mode acts like readline.
opt.wildmode      = { "longest", "full" }
opt.completeopt   = { "menu", "longest", "noselect" }

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

opt.swapfile      = false
opt.updatetime    = 100

-- always show sign columns.
opt.signcolumn    = "yes"

-- highlight cursor.
opt.cursorline    = true
opt.cursorcolumn  = true

-- neovim builtins
g.loaded_ruby_provider     = false
g.loaded_perl_provider     = false
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


-- vim-autoclose
g.AutoClosePreserveDotReg = false


-- vim-hybrid
-- set options for hybrid color scheme, the order here makes sense
g.hybrid_custom_term_colors = true
g.hybrid_reduced_contrast   = true
cmd "silent! colorscheme hybrid"
opt.background = "dark"


-- vim-gitgutter
-- realtime update
g.gitgutter_terminal_reports_focus = false
cmd "hi! link SignColumn      LineNr"
cmd "hi  link GitGutterAdd    diffAdded"
cmd "hi  link GitGutterDelete diffRemoved"


-- NERDTree
-- Change CWD whenever the root of NERDTree is changed. This is used for
-- auto-ch againest bookmark
g.NERDTreeChDirMode  = 2
g.NERDTreeShowHidden = true
g.NERDTreeIgnore     = { "\\~$" }


-- vim-startify
-- Change session dir to nvim style
g.startify_session_dir         = "~/.local/share/nvim/session"
-- Change startify's list order
g.startify_list_order          = { "sessions"
                                 , "bookmarks"
                                 , "dir"
                                 , "files"
                                 , "commands"
                                 }
-- Always update old files
g.startify_update_oldfiles     = true
-- Auto-save when opening a new session or leaving vim
g.startify_session_persistence = true
-- Sort sessions by modification time
g.startify_session_sort        = true
-- Close all buffers not need to save
g.startify_session_before_save = { "silent! tabdo NERDTreeClose"
                                 }

-- coc.nvim
-- install missing extensions
g.coc_global_extensions   = { "coc-json"
                            , "coc-toml"
                            , "coc-html"
                            , "coc-tsserver"
                            , "coc-pyright"
                            , "coc-lists"
                            , "coc-css"
                            , "coc-emmet"
                            , "coc-eslint"
                            , "coc-sql"
                            , "coc-go"
                            , "coc-metals"
                            , "coc-java"
                            , "coc-db"
                            , "coc-julia"
                            , "coc-clangd"
                            , "coc-sumneko-lua"
                            }
g.coc_status_error_sign   = "E"
g.coc_status_warning_sign = "W"

-- vim-markdown-toc
g.vmt_auto_update_on_save = false
g.vmt_fence_text          = "TOC"
g.vmt_list_item_char      = "-"

-- editorconfig
g.EditorConfig_exclude_patterns = { "fugitive://.*" }

-- keymaps

map { "", "(", "[(" }
map { "", ")", "])" }
-- Map switch of NERDTree to A-n
map { "", "<A-n>", ":NERDTreeToggle<CR>" }
-- Map sub-word movement commands
map { "", "<A-w>", "<Plug>CamelCaseMotion_w" }
map { "", "<A-b>", "<Plug>CamelCaseMotion_b" }
map { "", "<A-e>", "<Plug>CamelCaseMotion_e" }
-- Map [[ and ]] to move in err list
map { "", "[[", ":lprevious<CR>" }
map { "", "]]", ":lnext<CR>" }
-- Efficient tab management
map { "", "<S-A-h>", ":tabprevious<CR>" }
map { "", "<S-A-l>", ":tabnext<CR>" }
map { "", "<A-t>"  , ":tabnew<CR>" }
map { "", "<S-A-w>", ":tabclose<CR>" }
-- Efficient buffer switching
map { "", "<A-h>", ":bprevious<CR>" }
map { "", "<A-l>", ":bnext<CR>" }
-- Efficient pane switching
map { "", "<C-h>", "<C-w>h" }
map { "", "<C-l>", "<C-w>l" }
map { "i", "<Tab>"  , "pumvisible() ? '<Down>' : '<Tab>'", expr = true }
map { "i", "<S-Tab>", "pumvisible() ? '<Up>' : '<S-Tab>'", expr = true }
map { "i", "<C-x><C-o>", "coc#refresh()", expr = true }

map { "i", "<CR>", "complete_info(['selected']).selected == -1 ? '<CR>' : '<C-y>'", expr = true }

map { "n", "<C-p>"  , ":CocList files<CR>" }
map { "n", "<S-A-p>", ":CocList grep<CR>" }
map { "n", "<S-A-d>", ":CocList diagnostics<CR>" }
map { "n", "<A-f>", "<Plug>(coc-fix-current)" }
map { "n", "<A-a>", "<Plug>(coc-codeaction-cursor)" }
map { "n", "<A-c>", "<Plug>(coc-codelens-action)" }
map { "n", "<A-]>", "<Plug>(coc-definition)" }
map { "n", "<A-r>", "<Plug>(coc-references-used)" }
map { "n", "<A-)>", "<Plug>(coc-diagnostic-next)" }
map { "n", "<A-(>", "<Plug>(coc-diagnostic-prev)" }
map { "n", "K", ":call show_documentation()<CR>" }

-- mapping for hover scroll
map { "n", "<C-f>", "coc#float#has_scroll() ? coc#float#scroll(1, 10) : '<C-f>'"            , expr = true }
map { "n", "<C-b>", "coc#float#has_scroll() ? coc#float#scroll(0, 10) : '<C-b>'"            , expr = true }
map { "i", "<C-f>", "coc#float#has_scroll() ? <C-r>=coc#float#scroll(1, 10)<CR> : '<Right>'", expr = true }
map { "i", "<C-b>", "coc#float#has_scroll() ? <C-r>=coc#float#scroll(0, 10)<CR> : '<Left>'" , expr = true }

-- mapping for command line readline-style moves
map { "c", "<C-a>", "<Home>" }
map { "c", "<C-b>", "<Left>" }
map { "c", "<C-d>", "<Del>" }
map { "c", "<C-f>", "<Right>" }
