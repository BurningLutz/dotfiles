local opt = vim.opt
local cmd = vim.cmd
local map = vim.keymap
local fn  = vim.fn
local g   = vim.g


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
map.set("", "(", "[(")
map.set("", ")", "])")


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
                                 , "silent! call "
                                     .. fn.expand "<SID>"
                                     .. "close_terminal_buffers()"
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
-- Map switch of NERDTree to A-n
map.set("", "<A-n>", ":NERDTreeToggle<CR>", { silent = true })
-- Map sub-word movement commands
map.set("", "<A-w>", "<Plug>CamelCaseMotion_w", { silent = true })
map.set("", "<A-b>", "<Plug>CamelCaseMotion_b", { silent = true })
map.set("", "<A-e>", "<Plug>CamelCaseMotion_e", { silent = true })
-- Map [[ and ]] to move in err list
map.set("", "[[", ":lprevious<CR>", { silent = true })
map.set("", "]]", ":lnext<CR>"    , { silent = true })
-- Efficient tab management
map.set("", "<S-A-h>", ":tabprevious<CR>", { silent = true })
map.set("", "<S-A-l>", ":tabnext<CR>"    , { silent = true })
map.set("", "<A-t>"  , ":tabnew<CR>"     , { silent = true })
map.set("", "<S-A-w>", ":tabclose<CR>"   , { silent = true })
-- Efficient buffer switching
map.set("", "<A-h>", ":bprevious<CR>", { silent = true })
map.set("", "<A-l>", ":bnext<CR>"    , { silent = true })
-- Efficient pane switching
map.set("", "<C-h>", "<C-w>h", { silent = true })
map.set("", "<C-l>", "<C-w>l", { silent = true })
map.set("i", "<Tab>", "pumvisible() ? '<Down>' : '<Tab>'", { expr = true })
map.set("i", "<S-Tab>", "pumvisible() ? '<Up>' : '<S-Tab>'", { expr = true })
map.set("i", "<C-x><C-o>", "coc#refresh()", { expr = true })

map.set("i", "<CR>", [[
  complete_info(['selected']).selected == -1
  ? <SID>prev_char_is_pair()
     ? '<C-R>="<C-V><CR><C-V><Esc>O"<CR>'
     : '<CR>'
  : '<C-y>'
]], { expr = true })

map.set("n", "<C-p>", ":CocList files<CR>", { silent = true })
map.set("n", "<S-A-p>", ":CocList grep<CR>", { silent = true })
map.set("n", "<S-A-d>", ":CocList diagnostics<CR>", { silent = true })
map.set("n", "<A-f>", "<Plug>(coc-fix-current)", { silent = true })
map.set("n", "<A-a>", "<Plug>(coc-codeaction-cursor)", { silent = true })
map.set("n", "<A-c>", "<Plug>(coc-codelens-action)", { silent = true })
map.set("n", "<A-]>", "<Plug>(coc-definition)", { silent = true })
map.set("n", "<A-r>", "<Plug>(coc-references-used)", { silent = true })
map.set("n", "<A-)>", "<Plug>(coc-diagnostic-next)", { silent = true })
map.set("n", "<A-(>", "<Plug>(coc-diagnostic-prev)", { silent = true })
map.set("n", "K", ":call <SID>show_documentation()<CR>", { silent = true })

-- mapping for hover scroll
map.set("n", "<C-f>", "coc#float#has_scroll() ? coc#float#scroll(1, 10) : <C-f>", { silent = true, expr = true })
map.set("n", "<C-b>", "coc#float#has_scroll() ? coc#float#scroll(0, 10) : <C-b>", { silent = true, expr = true })
map.set("i", "<C-f>", "coc#float#has_scroll() ? <C-r>=coc#float#scroll(1, 10)<CR> : <Right>", { silent = true, expr = true })
map.set("i", "<C-b>", "coc#float#has_scroll() ? <C-r>=coc#float#scroll(0, 10)<CR> : <Left>", { silent = true, expr = true })

-- mapping for command line readline-style moves
map.set("c", "<C-a>", "<Home>")
map.set("c", "<C-b>", "<Left>")
map.set("c", "<C-d>", "<Del>")
map.set("c", "<C-f>", "<Right>")
