" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Useful toolbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'w0ng/vim-hybrid'

" Zen!
Plug 'mattn/emmet-vim'

" Dir tree, bookmarks and more
Plug 'scrooloose/nerdtree'

" Show file change inline
Plug 'airblade/vim-gitgutter'

" Syntax highlighter for js
Plug 'pangloss/vim-javascript'
" Extend js highlighter with jsx
Plug 'mxw/vim-jsx'

" Async program runner, I use it as syntax checker
Plug 'neomake/neomake'

" Readline style key bindings
Plug 'tpope/vim-rsi'

" Sub-word movements
Plug 'bkad/CamelCaseMotion'

" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround'

" 🔗 The fancy start screen for Vim.
Plug 'mhinz/vim-startify'

" Automatically insert paired quotes, brackets etc
Plug 'jiangmiao/auto-pairs'

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" Generate jsdoc
Plug 'heavenshell/vim-jsdoc'

" Align something
Plug 'vim-scripts/Align'

" Search and replace through the whole project
Plug 'dyng/ctrlsf.vim'

" GFM syntax
Plug 'rhysd/vim-gfm-syntax'

" User defined textobj support and text object for xml/html attrs
Plug 'kana/vim-textobj-user'
Plug 'inside/vim-textobj-jsxattr'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" auto-complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'carlitux/deoplete-ternjs'

" repeat plugin map
Plug 'tpope/vim-repeat'

" comment stuffs easily
Plug 'tpope/vim-commentary'

" text object for functions
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'

Plug 'posva/vim-vue'

Plug 'vim-ruby/vim-ruby'
" text object for ruby block
Plug 'nelstrom/vim-textobj-rubyblock'

" Initialize plugin system
call plug#end()

" set options for hybrid color scheme, the order here makes sense
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
" Try to set color scheme
silent! colorscheme hybrid
set background=dark

let g:user_emmet_leader_key = '<c-q>'
" Let emmet expand abbr for react
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" Set the color scheme of airline
let g:airline_theme = 'hybrid'

" Change CWD whenever the root of NERDTree is changed. This is used for
" auto-ch againest bookmark
let NERDTreeChDirMode = 2
let NERDTreeIgnore=['\~$', 'node_modules', 'dist']

let g:neomake_error_sign = { 'text': 'x' }
" Make eslint be the default linter, this need eslint to be installed
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_ruby_enabled_makers = ['rubocop']

" Disable some settings and keymaps of AutoPairs
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsMapCh = 0
let g:AutoPairsCenterLine = 0
let g:AutoPairsMultilineClose = 0

" Customize CtrlP window
let g:ctrlp_match_window = 'order:ttb,max:15,results:50'
" Bind c-h to move cursor left
let g:ctrlp_prompt_mappings = { 'PrtCurLeft()': ['<c-h>'] }
" Use git listing command to speed up, add grep to filter results
let g:ctrlp_user_command = {
      \  'types': {
      \    1: ['.git', 'cd %s ; git ls-files -coX .gitignore']
      \  },
      \  'ignore': 1
      \}
" Because I use git to speed up listing, I could disable caching for a
let g:ctrlp_custom_ignore = '\v(node_modules|dist)'
let g:ctrlp_use_caching = 0

" Change session dir to nvim style
let g:startify_session_dir = '~/.local/share/nvim/session'
" Change startify's list order
let g:startify_list_order = ['sessions', 'bookmarks', 'dir', 'files', 'commands']
" Always update old files
let g:startify_update_oldfiles = 1
" Auto-save when opening a new session or leaving vim
let g:startify_session_persistence = 1
" Sort sessions by modification time
let g:startify_session_sort = 1

let g:jsx_ext_required = 0

" Disable meta key binding of rsi
let g:rsi_no_meta = 1

" Prompt for doc generating
let g:jsdoc_input_description = 1
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_underscore_private = 1
let g:jsdoc_enable_es6 = 1

" Highlight jsdoc
let g:javascript_plugin_jsdoc = 1

" Highlight code block in markdown
let g:markdown_fenced_languages = ['json', 'js=javascript', 'jsx=javascript', 'html', 'css', 'scss']

" Show signature in completion list
let g:tern_show_signature_in_pum = 1
let g:tern#filetypes = ['javascript.jsx']

" Enable deoplete by default
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_delay = 10

let g:UltiSnipsExpandTrigger = '<C-h>'

" Make completion for command line mode acts like readline
set wildmode=longest,full

" Remove preview
set completeopt-=preview
set completeopt+=longest,noselect

" Enable 24-bits true color in neovim
" set termguicolors

" Make tab to insert 2 space characters
set tabstop=2
set shiftwidth=2
set expandtab

" Show line number
set number

" Open new pane at right bottom
set splitbelow
set splitright

" Don't use swap files. Cause more trouble than they're worth; saving often,
" undofiles, and committing often are better ways to avoid losing things.
set noswapfile

" Set language to en
language en_US.UTF-8

" Auto-run Neomake when save
autocmd! BufWritePost *.js,*.jsx,*.rb Neomake
" Or tipically when reload a file. This could happen when reverting changes
" from git
autocmd! BufReadPost *.js,*.jsx,*.rb Neomake

" Map switch of NERDTree to A-n
map <silent> <A-n> :NERDTreeToggle<CR>

" Map sub-word movement commands
map <silent> <A-w> <Plug>CamelCaseMotion_w
map <silent> <A-b> <Plug>CamelCaseMotion_b
map <silent> <A-e> <Plug>CamelCaseMotion_e

" Efficient tab management
map <silent> <S-A-h> :tabprevious<CR>
map <silent> <S-A-l> :tabnext<CR>
map <silent> <A-t> :tabnew<CR>
map <silent> <S-A-w> :tabclose<CR>

" Efficient buffer switching
map <silent> <A-h> :bprevious<CR>
map <silent> <A-l> :bnext<CR>

" Efficient pane switching
map <silent> <C-h> <C-w>h
map <silent> <C-l> <C-w>l

" Map <S-A-t> to open new iTerm tab
map <silent> <expr> <S-A-t> CreateItermTabWithCurrentPwd()

imap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
imap <expr> <Tab> pumvisible() ? '<Down>' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<Up>' : '<S-Tab>'

inoremap <C-X><C-F> <C-\><C-O>:<C-U>if expand('%:h') != ''
      \<BAR>let b:cwd = getcwd()
      \<BAR>cd %:h
      \<BAR>endif<CR><C-X><C-F>

augroup AutoRestore
  au!
  au CompleteDone * call RestoreCwd()
augroup END

function! SaveCwd()
endfunction

function! RestoreCwd()
  if exists('b:cwd')
    exec 'cd' b:cwd
    unlet b:cwd
  endif
endfunction

" A function to create new iTerm tab and set pwd to the vim one, macOS and
" iTerm only
function! CreateItermTabWithCurrentPwd()
  let pwd = getcwd()
  echo system(''.
        \'osascript'.
        \' -e ''tell application "iTerm"'''.
        \' -e ''  tell current window'''.
        \' -e ''    create tab with default profile'''.
        \' -e ''    tell current session'''.
        \' -e ''      write text "cd '. pwd .'" '''.
        \' -e ''    end tell'''.
        \' -e ''  end tell'''.
        \' -e ''end tell'''.
        \'')
endfunction

if has('nvim')
  " Enable mode-sensitive cursor-shape change.
  :set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175
endif
