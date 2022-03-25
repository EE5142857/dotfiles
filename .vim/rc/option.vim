scriptencoding utf-8

" --------------------------------------
" system
" {{{
set autoread
set nobackup
set noswapfile
set noundofile
set nowritebackup
" set shell=pwsh " grep error occurred

if has('win32') || has('win64') || has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif
" }}}

" --------------------------------------
" edit
" {{{
" set binary noeol
set fileencodings=utf-8,cp932,euc-jp
set hidden
" set isfname-=|
set noshellslash
set nrformats=
set virtualedit=block

if exists('&completeslash')
  set completeslash=slash
endif
" }}}

" --------------------------------------
" search
" {{{
set grepprg=grep\ -n
set hlsearch
set ignorecase
set incsearch
set shortmess-=S
set smartcase
set wrapscan
" }}}

" --------------------------------------
" view
" {{{
set ambiwidth=double
set display=lastline
set number
set title titlestring=Vim
" }}}

" --------------------------------------
" wildmenu
" pum
" {{{
set pumheight=10
set wildmenu wildmode=list:longest

if has('nvim')
  set pumblend=30
endif
" }}}

" --------------------------------------
" window
" {{{
set noequalalways
set splitbelow
set splitright
" }}}

" --------------------------------------
" status line
" tab line
" command line
" {{{
set laststatus=2
set showtabline=2
set cmdheight=2
" }}}

" --------------------------------------
" highlight
" {{{
set cursorline
set showmatch matchtime=1
set spelllang+=cjk spell

" '␣': U+2423 Open Box
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:»,precedes:«
" }}}

" --------------------------------------
" color
" {{{
set t_Co=256
if exists('&termguicolors')
  set termguicolors
endif
" }}}

" --------------------------------------
" abbreviation
" {{{
" avoiding :w'
abbreviate w' w
" }}}
