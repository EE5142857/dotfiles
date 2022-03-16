" TODO: 全ファイル開く
" TODO: バッファ内検索
" TODO: バッファ内置換
" TODO: easymotion
" TODO: deno
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

" Command
nnoremap <Space>vs :call VTStart()<CR>
nnoremap <Space>ve :call VTExecute()<CR>

" Terminal
tnoremap <C-[> <C-\><C-n>

" Insert
inoremap ,date <C-r>=strftime('%Y-%m-%d %a')<CR>

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
if has('nvim')
  " set shada=!,'100,<50,s10,h
  " https://neovim.io/doc/user/options.html#'shada'
  " set shada+=f0
else
  " https://vimhelp.org/options.txt.html#%27viminfo%27
  set viminfo=
endif

augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
  \ if (line("'\"") >= 1) && (line("'\"") <= line("$")) && (&ft !~# 'commit')
  \|  exe "normal! g`\""
  \|endif
augroup END

augroup DeleteMarks
  autocmd!
  " autocmd BufReadPost * delmarks a-z
  " autocmd VimLeavePre * delmarks 0-9[]^.<>\" | wshada!
  " autocmd VimLeavePre * delmarks A-Z | wshada!
augroup END

augroup UpdateRegisters
  autocmd!
  " autocmd VimLeavePre *
  "\ let regs = split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  "\|for r in regs
  "\|  call setreg(r, [])
  "\|endfor
  "\|wshada!

  " filename-modifiers
  autocmd BufEnter *
  \ let @a = substitute(fnamemodify(@%, ':p'), '\/', '\\', 'g')
  \|let @b = substitute(fnamemodify(@%, ':p:h'), '\/', '\\', 'g')
  \|let @c = substitute(fnamemodify(getcwd(), ':p:h'), '\/', '\\', 'g')
  \|let @d = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  \|let @e = substitute(fnamemodify(@%, ':p:h'), '\\', '\/', 'g')
  \|let @f = substitute(fnamemodify(getcwd(), ':p:h'), '\\', '\/', 'g')
  \|let @g = fnamemodify(@%, ':t')

  " jobid (= b:terminal_job_id)
  if has('nvim')
    autocmd BufLeave * let @z = &channel
  endif
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

command! -nargs=1 F
\ execute 'vimgrep /' . <args> . '/g **/* | cw'

command! -nargs=1 P
\ execute 'let @* = @' . <args>

command! -nargs=0 FixWhitespace
\ execute '%s/\s\+$//e'

command! -nargs=? T call T(<f-args>)
function! T(...) abort
  execute 'split | wincmd j | resize 5'

  if has('nvim')
    execute 'terminal'
    execute 'startinsert'
  else
    execute 'terminal ++curwin'
  endif

  if a:0 > 0
    call feedkeys(a:1 . "\<CR>")
  endif

  if has('nvim')
    call feedkeys("\<C-\>\<C-n>\<C-w>h")
  endif
endfunction

command! -nargs=? VT call VT(<f-args>)
function! VT(...) abort
  execute 'vsplit | wincmd l'

  if has('nvim')
    execute 'terminal'
    execute 'startinsert'
  else
    execute 'terminal ++curwin'
  endif

  if a:0 > 0
    call feedkeys(a:1 . "\<CR>")
  endif

  if has('nvim')
    call feedkeys("\<C-\>\<C-n>\<C-w>h")
  endif
endfunction

function! VTStart() abort
  let l:filetype  = &filetype
  let l:fileext   = fnamemodify(@%, ':e')

  if has('nvim') && (l:fileext == 'ipynb')
    call StartJupyter()
  elseif l:filetype == 'python'
    call StartPython()
  elseif l:filetype == 'sql'
    call StartSQL()
  else
    echo l:filetype 'unavailavle'
    return
  endif
endfunction

function! StartJupyter() abort
  execute 'wincmd l'
  call feedkeys("i")
  call feedkeys("activate\<CR>")
  call feedkeys("ipython\<CR>")

  if has('nvim')
    call feedkeys("\<C-\>\<C-n>\<C-w>h")
  endif
endfunction

function! StartPython() abort
  execute 'wincmd l'
  call feedkeys("i")
  call feedkeys("activate\<CR>")

  if has('nvim')
    call feedkeys("\<C-\>\<C-n>\<C-w>h")
  endif
endfunction

function! StartSQL() abort
  " defined in local.vim
endfunction

function! VTExecute() abort
  let l:filetype  = &filetype
  let l:filepath  = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  let l:fileext   = fnamemodify(@%, ':e')

  if has('nvim') && (l:fileext == 'ipynb')
    execute 'IPythonCellExecuteCell'
    execute 'wincmd l'
    call feedkeys("i\<CR>")
  elseif l:filetype == 'python'
    execute 'wincmd l'
    call feedkeys("i" . l:filepath . "\<CR>")
  elseif l:filetype == 'sql'
    execute 'wincmd l'
    call feedkeys("i\\i " . l:filepath . "\<CR>")
  elseif l:filetype == 'r'
    execute 'wincmd l'
    call feedkeys("irscript --encoding=utf-8 " . l:filepath . "\<CR>")
  else
    echo l:filetype 'unavailavle'
    return
  endif

  if has('nvim')
    call feedkeys("\<C-\>\<C-n>\<C-w>h")
  endif
endfunction

" --------------------------------------
" Local Settings
"
" ```vimscript:local.vim
" if index(g:sourced_list, fnamemodify(@%, ':p')) < 0
"   Silent ctags -R .
" endif
"
" let g:python3_host_prog = 'C:\work\myenv\Scripts\python.exe'
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
  if (&buftype == 'terminal') || (&buftype == 'quickfix')
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
