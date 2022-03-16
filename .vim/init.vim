" TODO: ddc.vim
" TODO: ddu.vim
" TODO: diff
" [.vim directory layout]
" ~/.vim/init.vim
" ~/.vim/rc/dein.vim
" ~/.vim/rc/dein_nvim.toml
" ~/.vim/rc/dein_nvim_lazy.toml
" ~/.vim/rc/dein_vim.toml
" ~/.vim/rc/dein_vim_lazy.toml
" ~/.vim/rc/func.vim
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
if filereadable(fnamemodify('~/.vim/rc/dein.vim', ':p'))
  source ~/.vim/rc/dein.vim
endif

" Required:
filetype plugin indent on
syntax enable

" --------------------------------------
" func.vim
"
if filereadable(fnamemodify('~/.vim/rc/func.vim', ':p'))
  source ~/.vim/rc/func.vim
endif

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
nnoremap <silent> <Space>ei :tabedit ~/.vim/init.vim<CR>
nnoremap <silent> <Space>si :source ~/.vim/init.vim<CR>

" QuickFix
nnoremap <silent> <Space>k :cprevious<CR>
nnoremap <silent> <Space>j :cnext<CR>
nnoremap <silent> <Space>gg :<C-u>cfirst<CR>
nnoremap <silent> <Space>G :<C-u>clast<CR>

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
" set binary noeol
set autochdir
set autoread
set clipboard=unnamed
set hidden
set isfname-=? " file?line separator
set nobackup
set noswapfile
set noundofile
set nowritebackup
set nrformats=

augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
  \ if (line("'\"") >= 1) && (line("'\"") <= line("$")) && (&ft !~# 'commit')
  \|  exe "normal! g`\""
  \|endif
augroup END

augroup DeleteMarks
  autocmd!
  autocmd BufReadPost * delmarks a-z
augroup END

augroup UpdateRegisters
  autocmd!
  autocmd VimLeavePre *
  \ let regs = split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  \|for r in regs
  \|  call setreg(r, [])
  \|endfor
  \|if has('nvim')
  \|  wshada!
  \|else
  \|  wviminfo!
  \|endif

  " filename-modifiers
  autocmd BufEnter *
  \ let @a = substitute(fnamemodify(@%, ':p'), '\/', '\\', 'g')
  \|let @b = substitute(fnamemodify(@%, ':p:h'), '\/', '\\', 'g')
  \|let @c = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  \|let @d = substitute(fnamemodify(@%, ':p:h'), '\\', '\/', 'g')
  \|let @e = fnamemodify(@%, ':t')

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
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:»,precedes:«
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
  " Width 2
  autocmd BufNewFile,BufRead *.mmd        setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.puml,*.pu  setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType css    setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType toml   setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType vim    setlocal shiftwidth=2 softtabstop=2 tabstop=2

  " Width 4
  autocmd FileType sql    setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END

" init.vim
setlocal shiftwidth=2 softtabstop=2 tabstop=2

" --------------------------------------
" Plugin
"
let g:netrw_home = '~/.vim'
let g:netrw_dirhistmax = 1

" --------------------------------------
" Local Settings
"
" https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
"
" ```vimscript:local.vim
" if index(g:sourced_list, fnamemodify(@%, ':p')) < 0
"   lcd <sfile>:p:h
"   Silent ctags -R .
" endif
"
" let g:python3_host_prog = 'C:\work\myenv\Scripts\python.exe'
" ```
"
augroup MyLocalVimrc
  autocmd!
  autocmd BufNewFile,BufReadPost,BufEnter * call SourceLocalVimrc(fnamemodify(@%, ':p'))
augroup END

if !exists('g:sourced_list')
  let g:sourced_list = []
endif
