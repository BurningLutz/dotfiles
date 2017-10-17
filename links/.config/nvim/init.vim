"*******************************************************************************
" PLUGINS                                                                      *
"*******************************************************************************
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" basis >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Useful toolbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" theme
Plug 'w0ng/vim-hybrid'
" Dir tree, bookmarks and more
Plug 'scrooloose/nerdtree'
" Show file change inline
Plug 'airblade/vim-gitgutter'
" Async program runner, I use it as syntax checker
Plug 'neomake/neomake'
" Readline style key bindings
Plug 'tpope/vim-rsi'
" Sub-word movements
Plug 'bkad/CamelCaseMotion'
" Surround.vim is all about "surroundings": parentheses, brackets, quotes,
" XML tags, and more. The plugin provides mappings to easily delete,
" change and add such surroundings in pairs.
Plug 'tpope/vim-surround'
" 🔗 The fancy start screen for Vim.
Plug 'mhinz/vim-startify'
" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" Align something
Plug 'vim-scripts/Align'
" Search and replace through the whole project
Plug 'dyng/ctrlsf.vim'
" snippet engine
Plug 'SirVer/ultisnips'
" useful snippets
Plug 'honza/vim-snippets'
" auto-complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" repeat plugin map
Plug 'tpope/vim-repeat'
" comment stuffs easily
Plug 'tpope/vim-commentary'
" auto close pairs
Plug 'BurningLutz/vim-autoclose'
" basis <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" web related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Zen!
Plug 'mattn/emmet-vim'
" js syntax highlight
Plug 'pangloss/vim-javascript'
" Extend js highlighter with jsx
Plug 'mxw/vim-jsx'
" Generate jsdoc
Plug 'heavenshell/vim-jsdoc'
" GFM syntax highlight
Plug 'rhysd/vim-gfm-syntax'
" User defined textobj support and text object for xml/html attrs
Plug 'kana/vim-textobj-user'
Plug 'inside/vim-textobj-jsxattr'
" text object for functions
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'
" vue syntax highlight
Plug 'posva/vim-vue'
" web related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" ruby related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" ruby syntax and completion
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
" text object for ruby block
Plug 'nelstrom/vim-textobj-rubyblock'
" ruby related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" clojure related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" clojure utilities
Plug 'tpope/vim-fireplace'
" speedup fireplace's awful omni completion
Plug 'clojure-vim/async-clj-omni'
" clojure syntax highlight
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
" better parentheses colors
Plug 'kien/rainbow_parentheses.vim'
" clojure related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" fish related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Plug 'dag/vim-fish'
" fish related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" Initialize plugin system
call plug#end()

"*******************************************************************************
" SETTINGS                                                                     *
"*******************************************************************************
" global stuffs >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
" global stuffs <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" rainbow_parentheses.vim >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:rbpt_colorpairs = [
\ ['brown'       , 'RoyalBlue3'  ],
\ ['Darkblue'    , 'SeaGreen3'   ],
\ ['darkgray'    , 'DarkOrchid3' ],
\ ['darkgreen'   , 'firebrick3'  ],
\ ['darkcyan'    , 'RoyalBlue3'  ],
\ ['darkred'     , 'SeaGreen3'   ],
\ ['darkmagenta' , 'DarkOrchid3' ],
\ ['brown'       , 'firebrick3'  ],
\ ['gray'        , 'RoyalBlue3'  ],
\ ['darkmagenta' , 'DarkOrchid3' ],
\ ['Darkblue'    , 'firebrick3'  ],
\ ['darkgreen'   , 'RoyalBlue3'  ],
\ ['darkcyan'    , 'SeaGreen3'   ],
\ ['darkred'     , 'DarkOrchid3' ],
\ ['red'         , 'firebrick3'  ],
\ ]
let g:rbpt_max = 15
let g:rbpt_loadcmd_toggle = 0
autocmd VimEnter *       RainbowParenthesesToggle
autocmd Syntax   clojure RainbowParenthesesLoadRound
autocmd Syntax   clojure RainbowParenthesesLoadSquare
autocmd Syntax   clojure RainbowParenthesesLoadBraces
" rainbow_parentheses.vim <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" vim-clojure-static >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Align subsequent lines in multiline strings to the column after the opening
" quote, instead of the same column.
let g:clojure_align_multiline_strings = 1
let g:AutoClosePreserveDotReg = 0
let g:AutoCloseExpandEnterOn = '{[('
autocmd FileType clojure let b:AutoClosePairs = AutoClose#ParsePairs("() [] {} \"")
map <silent> ( [(
map <silent> ) ])
" vim-clojure-static <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" set color theme >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" set options for hybrid color scheme, the order here makes sense
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
" Try to set color scheme
silent! colorscheme hybrid
set background=dark
" Set the color scheme of airline
let g:airline_theme = 'hybrid'
" set color theme <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" emmet >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:user_emmet_leader_key = '<c-q>'
" Let emmet expand abbr for react
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
" emmet <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" NERDTree >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Change CWD whenever the root of NERDTree is changed. This is used for
" auto-ch againest bookmark
let NERDTreeChDirMode = 2
let NERDTreeIgnore=['\~$', 'node_modules', 'dist', '.git']
" NERDTree <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" neomake >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:neomake_error_sign = { 'text': 'x>', 'texthl': 'NeomakeErrorSign' }
let g:neomake_warning_sign = { 'text': '!>' }
hi link NeomakeError Error
hi link NeomakeErrorSign Error
" Make eslint be the default linter, this need eslint to be installed
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_ruby_enabled_makers = ['rubocop']
" neomake <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" ctrlp >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
" ctrlp <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" startify >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Change session dir to nvim style
let g:startify_session_dir = '~/.local/share/nvim/session'
" Change startify's list order
let g:startify_list_order = ['sessions', 'bookmarks', 'dir', 'files',
                            \'commands']
" Always update old files
let g:startify_update_oldfiles = 1
" Auto-save when opening a new session or leaving vim
let g:startify_session_persistence = 1
" Sort sessions by modification time
let g:startify_session_sort = 1
" startify <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" deoplete >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Enable deoplete by default
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_camel_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#auto_complete_delay = 50

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'

call deoplete#custom#source('_', 'converters', [
\ 'converter_remove_paren',
\ 'converter_remove_overlap',
\ 'converter_truncate_abbr',
\ 'converter_truncate_menu',
\ ])
call deoplete#custom#source('_', 'sorters', ['sorter_word'])
" deoplete <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" web related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
let g:markdown_fenced_languages = ['json', 'js=javascript', 'jsx=javascript',
                                  \'html', 'css', 'scss']
" Show signature in completion list
let g:tern_show_signature_in_pum = 1
let g:tern#filetypes = ['javascript.jsx']
" highlight jsObjectKey for vim-javascript
hi link jsObjectKey Label
" web related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" ultisnips >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:UltiSnipsExpandTrigger = '<C-h>'
" ultisnips <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

"*******************************************************************************
" OPTIONS                                                                      *
"*******************************************************************************
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
" change cursor shape to vertical bar when in insert mode
if has('nvim')
  " Enable mode-sensitive cursor-shape change.
  :set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175
endif

"*******************************************************************************
" HOOKS                                                                        *
"*******************************************************************************
" Auto-run Neomake when save
au! BufWritePost *.js,*.jsx,*.rb Neomake
" Or tipically when reload a file. This could happen when reverting changes
" from git
au! BufReadPost *.js,*.jsx,*.rb Neomake

"*******************************************************************************
" KEYMAPS                                                                      *
"*******************************************************************************
" Map switch of NERDTree to A-n
map <silent> <A-n> :NERDTreeToggle<CR>
" Map sub-word movement commands
map <silent> <A-w> <Plug>CamelCaseMotion_w
map <silent> <A-b> <Plug>CamelCaseMotion_b
map <silent> <A-e> <Plug>CamelCaseMotion_e
" Map [[ and ]] to move in err list
map <silent> [[ :lprevious<CR>
map <silent> ]] :lnext<CR>
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

"*******************************************************************************
" USER COMMANDS                                                                *
"*******************************************************************************
:command! LeinRepl call OpenLeinRepl()

"*******************************************************************************
" FUNCTIONS                                                                    *
"*******************************************************************************

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

function! OpenLeinRepl()
  :tabnew
  :terminal lein repl :headless
  :stopinsert
  :tabrewind
endfunction
