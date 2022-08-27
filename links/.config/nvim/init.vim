"*******************************************************************************
" PLUGINS                                                                      *
"*******************************************************************************
" Plugins are declared within lua/plugins.lua
lua require("plugins")

lua << EOF
require"nvim-treesitter.configs".setup
{ auto_install = true
, highlight    = { enable = true
                 , additional_vim_regex_highlighting = false
                 }
, textobjects  = { select = { enable          = true
                            , keymaps         = { ["af"] = "@function.outer"
                                                , ["if"] = "@function.inner"
                                                , ["ac"] = "@class.outer"
                                                , ["ic"] = "@class.inner"
                                                }
                            , selection_modes = { ["@function.outer"] = "V"
                                                , ["@class.outer"]    = "V"
                                                }
                            , include_surrounding_whitespace = true
                            }
                 , swap   = { enable        = true
                            , swap_next     = { ["<leader>p"] = { "@parameter.inner" }
                                              }
                            , swap_previous = { ["<leader>P"] = { "@parameter.inner" }
                                          }
                            }
                 }
}
EOF
"*******************************************************************************
" SETTINGS                                                                     *
"*******************************************************************************
" neovim builtins >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:pyindent_open_paren = 0
let g:python_recommended_style = 0

" vim-autoclose >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:AutoClosePreserveDotReg = 0
map <silent> ( [(
map <silent> ) ])

" vim-hybrid >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" set options for hybrid color scheme, the order here makes sense
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
" Try to set color scheme
silent! colorscheme hybrid
set background=dark

" vim-gitgutter >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" realtime update
let g:gitgutter_terminal_reports_focus = 0
hi! link SignColumn      LineNr
hi link GitGutterAdd    diffAdded
hi link GitGutterDelete diffRemoved

" NERDTree >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Change CWD whenever the root of NERDTree is changed. This is used for
" auto-ch againest bookmark
let NERDTreeChDirMode  = 2
let NERDTreeShowHidden = 1
let NERDTreeIgnore =
\ ['\~$'
\ ]
" NERDTree <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

" vim-startify >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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

" coc.nvim >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
\ , 'coc-clangd'
\ , 'coc-sumneko-lua'
\ ]
let g:coc_status_error_sign = 'E'
let g:coc_status_warning_sign = 'W'

" vim-markdown-toc >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
let g:vmt_auto_update_on_save = 0
let g:vmt_fence_text = 'TOC'
let g:vmt_list_item_char = '-'

" web related >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Required for operations modifying multiple buffers like rename.
set hidden

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
nmap <silent> <C-p> :CocList files<CR>
nmap <silent> <S-A-p> :CocList grep<CR>
nmap <silent> <S-A-d> :CocList diagnostics<CR>
nmap <silent> <A-f> <Plug>(coc-fix-current)
nmap <silent> <A-a> <Plug>(coc-codeaction-cursor)
" nmap <silent> <A-c> <Plug>(coc-codelens-action)
nmap <silent> <A-]> <Plug>(coc-definition)
nmap <silent> <A-r> <Plug>(coc-references-used)
nmap <silent> <A-)> <Plug>(coc-diagnostic-next)
nmap <silent> <A-(> <Plug>(coc-diagnostic-prev)
nnoremap <silent> K :call <SID>show_documentation()<CR>

" mapping for hover scroll
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1, 10) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0, 10) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 10)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, 10)\<cr>" : "\<Left>"

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

function! s:close_terminal_buffers()
  let l:termlist = split(execute([':buffers R', ':buffers F']), "\n")

  for l:bufstr in l:termlist
    if l:bufstr =~ 'term://'
      let l:bufnum = matchstr(l:bufstr, '\d+')

      execute(':bdelete! '.l:bufnum)
    endif
  endfor
endfunction
