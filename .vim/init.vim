if 0
  finish " Skip initialization for vim-tiny or vim-small.
endif

if &compatible
  set nocompatible " Be iMproved
endif

" --------------------------------------
" Encoding
"
language message C
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,cp932

" --------------------------------------
" dein.vim
"
if filereadable(fnamemodify('~/.vim/dein/dein.vim', ':p'))
  source ~/.vim/dein/dein.vim
endif

" Required:
filetype plugin indent on
syntax enable

" --------------------------------------
" Keymap
"
let g:mapleader="\<Space>"

nnoremap Q <Nop>
nnoremap q <Nop>

nnoremap j gj
nnoremap k gk

nnoremap gf gF

" Toggle wrap
nnoremap <silent> <Space>tw :set wrap!<CR>

" Encoding
nnoremap <silent> <Space>es :edit ++encoding=cp932<CR>
nnoremap <silent> <Space>eu :edit ++encoding=utf-8<CR>

" .vimrc
nnoremap <silent> <Space>ed :tabedit ~/.vim/dein/dein.toml<CR>
nnoremap <silent> <Space>ei :tabedit ~/.vim/init.vim<CR>
nnoremap <silent> <Space>si :source ~/.vim/init.vim<CR>

" Command Line
nnoremap <silent> <Space>ac @:

" Terminal
tnoremap <C-[> <C-\><C-n>

" Insert
inoremap ,date <C-R>=strftime('%Y-%m-%d %a')<CR>

" --------------------------------------
" Edit
"
set autoread
set clipboard=unnamed
set hidden
set isfname-=#
set nobackup
set noswapfile
set noundofile
set nowritebackup
set nrformats=

augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \|  exe "normal! g`\""
  \|endif
augroup END

augroup ClearMarks
  autocmd!
  autocmd VimLeavePre * delmarks!
  autocmd BufEnter * delmarks 0-9[]^.<>\"
augroup END

augroup UpdateRegisters
  autocmd!
  autocmd VimLeavePre *
  \ let regs = split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  \|for r in regs
  \|  call setreg(r, [])
  \|endfor

  " filename-modifiers
  autocmd BufEnter *
  \ let @a = substitute(fnamemodify(@%, ':p:h'), '\/', '\\', 'g')
  \|let @b = substitute(fnamemodify(@%, ':p'), '\/', '\\', 'g')
  \|let @c = substitute(fnamemodify(@%, ':p:h'), '\\', '\/', 'g')
  \|let @d = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  \|let @e = fnamemodify(@%, ':t')
  \|let @f = fnamemodify(@%, ':t:r')
  \|let @g = fnamemodify(@%, ':p:h:t')

  " get jobid
  autocmd BufLeave *
  \ let @z = &channel
augroup END

" --------------------------------------
" Search & Replacement
"
set hlsearch
set ignorecase
set incsearch
set shortmess-=S
set smartcase
set wrapscan

" --------------------------------------
" View
"
set ambiwidth=double
set cursorline
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:>,precedes:<
set noequalalways
set number
set showmatch
set showtabline=2
set wildmenu wildmode=list:longest

" --------------------------------------
" Status Line
"
set laststatus=2
set noshowmode
set ruler

" --------------------------------------
" Color Scheme
"
" default dark color schemes
" colorscheme desert
" colorscheme elflord
" colorscheme industry
" colorscheme pablo

" default dark color schemes I won't set
" colorscheme blue
" colorscheme darkblue
" colorscheme default
" colorscheme delek
" colorscheme koehler
" colorscheme murphy
" colorscheme peachpuff
" colorscheme ron
" colorscheme slate
" colorscheme torte
" colorscheme zellner

" default light color schemes
" colorscheme evening
" colorscheme morning
" colorscheme shine

" --------------------------------------
" Spell
"
set spelllang+=cjk
set spell

" --------------------------------------
" Syntax
"
augroup MyMatchAdd
  autocmd!
  autocmd Syntax * call matchadd('Todo', 'TODO:\|FIXME:\|DEBUG:\|NOTE:\|WARNING:')
  autocmd Syntax * call matchadd('Error', '　\|\s\+$\|\[ \]')
augroup END

" --------------------------------------
" Highlight
"
highlight CursorLine  cterm=underline ctermfg=NONE ctermbg=NONE
highlight Error       cterm=NONE ctermfg=Black ctermbg=Red
highlight SpecialKey  cterm=NONE ctermfg=DarkGray ctermbg=NONE
highlight SpellBad    cterm=underline ctermfg=NONE ctermbg=NONE
highlight Todo        cterm=NONE ctermfg=Black ctermbg=Yellow
if has('nvim')
  highlight Whitespace  cterm=NONE ctermfg=DarkGray ctermbg=NONE
endif

" --------------------------------------
" Indent
"
set autoindent
set expandtab
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

" --------------------------------------
" File Type
"
augroup MyFileTypeSetting
  autocmd!
  autocmd BufNewFile,BufRead *.mmd        setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.puml,*.pu  setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType css,toml,vim           setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType sql                    setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END

" init.vim
setlocal shiftwidth=2 softtabstop=2 tabstop=2

" --------------------------------------
" Plugin
"
let g:netrw_home = '~/.vim'
let g:netrw_dirhistmax = 1

" --------------------------------------
" Function
"
command! -nargs=1 Silent
\ execute 'silent !' . <q-args>
\|execute 'redraw!'

command! -nargs=* T call T(<q-args>)
function! T(cmd) abort
  execute 'vsplit | wincmd j | resize 5'
  if has('nvim')
    execute 'terminal'
    execute 'startinsert'
  else
    execute 'terminal ++curwin'
  endif
  if a:cmd != ''
    call feedkeys(a:cmd . "\<CR>")
  endif
endfunction

command! -nargs=* VT call VT(<q-args>)
function! VT(cmd) abort
  execute 'vsplit | wincmd l'
  if has('nvim')
    execute 'terminal'
    execute 'startinsert'
  else
    execute 'terminal ++curwin'
  endif
  if a:cmd != ''
    call feedkeys(a:cmd . "\<CR>")
  endif
endfunction

command! -nargs=1 F call F(<q-args>)
function! F(str) abort
  execute 'vimgrep /' . a:str . '/g **/* | cw'
endfunction

command! -nargs=1 P call P(<q-args>)
function! P(reg) abort
  execute 'let @* = @' . a:reg
endfunction

command! -nargs=0 FixWhitespace call FixWhitespace()
function! FixWhitespace() abort
  execute '%s/\s\+$//e'
endfunction

command! -nargs=0 DeleteUppercaseMarks call DeleteUppercaseMarks()
function! DeleteUppercaseMarks() abort
  if has('nvim')
    " https://neovim.io/doc/user/options.html#'shada'
    set shada+=f0
  else
    " https://vimhelp.org/options.txt.html#%27viminfo%27
    set viminfo+=f0
  endif
endfunction

command! -nargs=0 ExecPSQL call ExecPSQL()
function! ExecPSQL() abort
  let l:filename = fnamemodify(@%, ':t')
  execute 'wincmd l'
  call feedkeys("i" . "\\i " . l:filename . "\<CR>\<Esc>\<C-w>\h")
endfunction

command! -nargs=0 ExecR call ExecR()
function! ExecR() abort
  let l:filename = fnamemodify(@%, ':t')
  execute 'wincmd l'
  call feedkeys("i" . "rscript --encoding=utf-8 " . l:filename . "\<CR>\<Esc>\<C-w>\h")
endfunction

" TODO: 全ファイル開く
" TODO: バッファ内検索
" TODO: バッファ内置換

" --------------------------------------
" Local Settings
"
" ```vimscript:local.vim
" lcd <sfile>:p:h
"
" if index(g:sourced_list, fnamemodify(@%, ':p')) < 0
"   Silent ctags -R .
" endif
"
" let g:python3_host_prog = 'C:\work\myenv\Scripts\python.exe'
" let g:slime_python_ipython = 1
" if exists('g:slime_python_ipython')
"   unlet g:slime_python_ipython
" endif
" ```
"
augroup MyLocalVimrc
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:SourceLocalVimrc(fnamemodify(@%, ':p'))
  autocmd BufEnter * call s:SourceLocalVimrc(fnamemodify(@%, ':p'))
augroup END

if !exists('g:sourced_list')
  let g:sourced_list = []
endif

function! s:SourceLocalVimrc(path) abort
  " reject shell buffer
  if stridx(a:path, 'cmd.exe') >= 0
    return
  endif

  execute 'lcd' fnamemodify(a:path, ':p:h')

  let l:find_list = findfile('local.vim', escape(a:path, ' ') . ';', -1)
  let l:relative_vimrc_list = reverse(l:find_list)
  let l:absolute_vimrc_list = []
  for l:i in l:relative_vimrc_list
    call add(l:absolute_vimrc_list, fnamemodify(l:i, ':p'))
  endfor

  for l:i in l:absolute_vimrc_list
    execute 'source' l:i

    if index(g:sourced_list, l:i) < 0
      call add(g:sourced_list, l:i)
    endif
  endfor
endfunction
