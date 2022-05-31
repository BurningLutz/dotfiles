"*******************************************************************************
" PLUGINS                                                                      *
"*******************************************************************************
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" basis >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Useful toolbar
Plug 'liuchengxu/eleline.vim'
" theme
Plug 'w0ng/vim-hybrid'
" Dir tree, bookmarks and more
Plug 'scrooloose/nerdtree'
" Show file change inline
Plug 'airblade/vim-gitgutter'
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

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Generate jsdoc
Plug 'heavenshell/vim-jsdoc'
" GFM syntax highlight
Plug 'rhysd/vim-gfm-syntax'
" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
" User defined textobj support and text object for xml/html attrs
Plug 'kana/vim-textobj-user'
Plug 'inside/vim-textobj-jsxattr'
" text object for functions
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'
" vue syntax highlight
Plug 'posva/vim-vue'
" web related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" fish related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Plug 'dag/vim-fish'
" fish related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" python related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Plug 'bps/vim-textobj-python'
Plug 'michaeljsmith/vim-indent-object'
" python related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" purescript related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Plug 'purescript-contrib/purescript-vim'
Plug 'vmchale/dhall-vim'
" purescript related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" haskell related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Plug 'neovimhaskell/haskell-vim'
" haskell related <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Plug 'chr4/nginx.vim'

Plug 'lifepillar/pgsql.vim'
" Initialize plugin system

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" db
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

call plug#end()

"*******************************************************************************
" SETTINGS                                                                     *
"*******************************************************************************
" global stuffs >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:python3_host_prog = '/usr/local/bin/python3'
let g:loaded_ruby_provider = 0
let g:pyindent_open_paren = 0
let g:python_recommended_style = 0
" global stuffs <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" vim-clojure-static >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:AutoClosePreserveDotReg = 0
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
" GitGutter <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" NERDTree >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Change CWD whenever the root of NERDTree is changed. This is used for
" auto-ch againest bookmark
let NERDTreeChDirMode  = 2
let NERDTreeShowHidden = 1
let NERDTreeIgnore =
\ ['\~$'
\ ]
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
" Close all buffers not need to save
let g:startify_session_before_save =
\ [ 'silent! tabdo NERDTreeClose'
\ , 'silent! call '.expand('<SID>').'close_terminal_buffers()'
\ ]
" startify <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" coc >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" install missing extensions
let g:coc_global_extensions =
\ [ 'coc-json'
\ , 'coc-toml'
\ , 'coc-html'
\ , 'coc-tsserver'
\ , 'coc-pyright'
\ , 'coc-lists'
\ , 'coc-css'
\ , 'coc-emmet'
\ , 'coc-eslint'
\ , 'coc-sql'
\ , 'coc-go'
\ , 'coc-metals'
\ , 'coc-java'
\ , 'coc-db'
\ , 'coc-julia'
\ ]
let g:coc_status_error_sign = 'E'
let g:coc_status_warning_sign = 'W'
" coc <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" web related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:vim_jsx_pretty_highlight_close_tag = 1
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

" haskell >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:haskell_enable_recursivedo = 1
" haskell <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" postgres >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:sql_type_default = 'pgsql'
" postgres <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" editorconfig >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" editorconfig <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" terminal mode colors >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:terminal_color_0  = '#282C34'
let g:terminal_color_1  = '#E06C75'
let g:terminal_color_2  = '#98C379'
let g:terminal_color_3  = '#E5C07B'
let g:terminal_color_4  = '#61AFEF'
let g:terminal_color_5  = '#C678DD'
let g:terminal_color_6  = '#56B6C2'
let g:terminal_color_7  = '#DCDFE4'
let g:terminal_color_8  = '#5A6374'
let g:terminal_color_9  = '#E06C75'
let g:terminal_color_10 = '#98C379'
let g:terminal_color_11 = '#E5C07B'
let g:terminal_color_12 = '#61AFEF'
let g:terminal_color_13 = '#C678DD'
let g:terminal_color_14 = '#56B6C2'
let g:terminal_color_15 = '#DCDFE4'
" terminal mode colors <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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
set termguicolors

" Make tab to insert 2 space characters
set tabstop=2
set shiftwidth=2
set expandtab

" enable listchars
set list lcs=tab:>-,trail:-,nbsp:+
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
au BufRead *.purs set fo+=rol fo-=t
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
imap <expr> <Tab> pumvisible() ? '<Down>' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<Up>' : '<S-Tab>'
imap <expr> <C-x><C-o> coc#refresh()
imap <expr> <CR>
      \ complete_info(['selected']).selected == -1
      \ ? <SID>prev_char_is_pair()
      \    ? '<C-R>="<C-V><CR><C-V><Esc>O"<CR>'
      \    : '<CR>'
      \ : '<C-y>'
" Map <C-p> to do :CocList files
nmap <silent> <C-p> :CocList files<CR>
" Map <C-A-p> to do :CocList lines
nmap <silent> <C-A-p> :CocList grep<CR>
" Map <C-A-d> to do :CocList diagnostics
nmap <silent> <C-A-d> :CocList diagnostics<CR>
" Map <A-f> to do :CocFix
nmap <silent> <A-f> :CocFix<CR>
" Map <A-a> to do coc-codeaction-cursor
nmap <silent> <A-a> <Plug>(coc-codeaction-cursor)
" Map <A-c> to do coc-codelens-action
nmap <silent> <A-c> <Plug>(coc-codelens-action)
" Map <A-]>(it's similar to <C-]>, which jump to a tag) to jump to definition
nmap <silent> <A-]> <Plug>(coc-definition)
" Map <A-r> to jump to (r)eferences
nmap <silent> <A-r> <Plug>(coc-references-used)
" Map coc-diagnostic-next
nmap <silent> <A-)> <Plug>(coc-diagnostic-next)
" Map coc-diagnostic-prev
nmap <silent> <A-(> <Plug>(coc-diagnostic-prev)
nnoremap <silent> K :call <SID>show_documentation()<CR>
" auto align columns inside `create table`
vmap <silent> <A-s> :Align! 0p0P-l \s\S<CR>
" map gl to echo syntax highlight group under cursor
nmap <silent> gl :echo <SID>syntax_item()<CR>

" mapping for hover scroll
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" mapping for command line readline-style moves
cnoremap        <C-A> <Home>
cnoremap   <C-X><C-A> <C-A>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

"*******************************************************************************
" USER COMMANDS                                                                *
"*******************************************************************************
:command! CR CocRestart

"*******************************************************************************
" FUNCTIONS                                                                    *
"*******************************************************************************

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:get_char_ahead(len)
  if col('$') == col('.')
    return "\0"
  endif
  return strpart(getline('.'), col('.')-2 + a:len, 1)
endfunction

function! s:get_char_behind(len)
  if col('.') == 1
    return "\0"
  endif
  return strpart(getline('.'), col('.') - (1 + a:len), 1)
endfunction

function! s:get_next_char()
  return s:get_char_ahead(1)
endfunction

function! s:get_prev_char()
  return s:get_char_behind(1)
endfunction

function! s:is_empty_pair()
  let l:prev = s:get_prev_char()
  let l:next = s:get_next_char()
  let l:auto_close_pairs = { "{": "}", "(": ")", "[": "]" }
  return (l:next != "\0") && (get(l:auto_close_pairs, l:prev, "\0") == l:next)
endfunction

function! s:prev_char_is_pair()
  return s:is_empty_pair() && stridx("[{(", s:get_prev_char()) >= 0
endfunction

function! s:syntax_item()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! s:close_terminal_buffers()
  let l:termlist = split(execute([':buffers R', ':buffers F']), "\n")

  for l:bufstr in l:termlist
    if l:bufstr =~ 'term://'
      let l:bufnum = matchstr(l:bufstr, '\d+')

      execute(':bdelete! '.l:bufnum)
    endif
  endfor
endfunction
