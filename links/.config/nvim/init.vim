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
" Readline style key bindings
Plug 'tpope/vim-rsi'
" Sub-word movements
Plug 'bkad/CamelCaseMotion'
" Surround.vim is all about "surroundings": parentheses, brackets, quotes,
" XML tags, and more. The plugin provides mappings to easily delete,
" change and add such surroundings in pairs.
Plug 'tpope/vim-surround'
" git wrapper
Plug 'tpope/vim-fugitive'
" 🔗 The fancy start screen for Vim.
Plug 'mhinz/vim-startify'
" Align something
Plug 'vim-scripts/Align'
" Search and replace through the whole project
Plug 'dyng/ctrlsf.vim'
" useful snippets
Plug 'honza/vim-snippets'
" auto-complete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" repeat plugin map
Plug 'tpope/vim-repeat'
" comment stuffs easily
Plug 'tpope/vim-commentary'
" auto close pairs
Plug 'BurningLutz/vim-autoclose'
" Jenkinsfile syntax
Plug 'martinda/Jenkinsfile-vim-syntax'
" basis <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" web related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Zen!
Plug 'mattn/emmet-vim'

" the order here is IMPORTANT
" js syntax highlight
Plug 'pangloss/vim-javascript'
" Extend js highlighter with jsx
Plug 'MaxMEllon/vim-jsx-pretty'

" Generate jsdoc
Plug 'heavenshell/vim-jsdoc'
" GFM syntax highlight
Plug 'rhysd/vim-gfm-syntax'
" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" User defined textobj support and text object for xml/html attrs
Plug 'kana/vim-textobj-user'
Plug 'inside/vim-textobj-jsxattr'
" text object for functions
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'
" vue syntax highlight
Plug 'posva/vim-vue'
" web related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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

" python related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Plug 'bps/vim-textobj-python'
" python related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Plug 'tomlion/vim-solidity'

Plug 'udalov/kotlin-vim'

Plug 'purescript-contrib/purescript-vim'

Plug 'michaeljsmith/vim-indent-object'

Plug 'jparise/vim-graphql'

" Initialize plugin system
call plug#end()

"*******************************************************************************
" SETTINGS                                                                     *
"*******************************************************************************
" global stuffs >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:pyindent_open_paren = 0
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
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
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

" GitGutter >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" realtime update
let g:gitgutter_terminal_reports_focus = 0

hi! link SignColumn LineNr
hi link GitGutterAdd diffAdded
hi link GitGutterDelete diffRemoved
hi link Whitespace Error
" GitGutter <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" NERDTree >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Change CWD whenever the root of NERDTree is changed. This is used for
" auto-ch againest bookmark
let NERDTreeChDirMode = 2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '^node_modules$', '^dist$', '^.git$', '^__pycache__$']
" NERDTree <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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

" coc >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" install missing extensions
call coc#add_extension(
  \'coc-json',
  \'coc-html',
  \'coc-tsserver',
  \'coc-python',
  \'coc-lists',
  \'coc-css',
  \'coc-emmet',
  \'coc-eslint',
  \)
" coc <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" web related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:vim_jsx_pretty_highlight_close_tag = 1
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

" Required for operations modifying multiple buffers like rename.
set hidden

" highlight jsObjectKey for vim-javascript
hi link jsObjectKey Label
" web related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" purescript >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let purescript_indent_if = 2
let purescript_indent_case = 2
let purescript_indent_let = 2
let purescript_indent_where = 2
let purescript_indent_do = 2
" purescript <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

"*******************************************************************************
" OPTIONS                                                                      *
"*******************************************************************************
" Agree with iTerm's treament of ambiguous-width chars, which is, treated as
" double-width
set ambiwidth=single
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
" show unexpected whitespaces as error
set list lcs=tab:\ \ \ ,trail:\ 
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
" reduce updatetime
set updatetime=100

" always show signcolumns
set signcolumn=yes

" highlight cursor
set cursorline
set cursorcolumn
"*******************************************************************************
" HOOKS                                                                        *
"*******************************************************************************
au BufRead *.jsx set ft=javascript.jsx

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
imap <expr> <Tab> pumvisible() ? '<Down>' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<Up>' : '<S-Tab>'
imap <expr> <CR> complete_info(['selected']).selected == -1 ? '<CR>' : '<C-y>'
" Map <C-p> to do :CocList files
nmap <silent> <C-p> :CocList files<CR>
" Map <A-]>(it's similar to <C-]>, which jump to a tag) to jump to definition
nmap <silent> <A-]> <Plug>(coc-definition)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
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
