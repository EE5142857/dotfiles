if &compatible
  set nocompatible " Be iMproved
endif

set encoding=utf-8
scriptencoding utf-8

language messages C

" --------------------------------------
" variable
" {{{
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_dirhistmax = 1
let g:netrw_home = '~/.vim'
let g:netrw_liststyle = 3
let g:netrw_sizestyle = 'H'
let g:netrw_special_syntax = 1
let g:netrw_timefmt = '%Y-%m-%d %H:%M:%S'
let g:netrw_winsize = 85
let g:vim_indent_cont = 0
" }}}

" --------------------------------------
" command
" {{{
" NOTE: vimgrep
  " :vimgrep /word/g **/*.*
" NOTE: argdo
  " :args **/*.*
  " :argdo %s/old/new/g | update
  " :argdo %s/old/new/gc | update
  " :argdelete *
" NOTE: cdo
  " :cdo %s/old/new/g | update
  " :cdo %s/old/new/gc | update
command! -nargs=1 P execute 'let @* = @' . <q-args>
command! -nargs=1 G execute 'grep -ri ' . <q-args> . ' .'
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'
" }}}

" --------------------------------------
" abbreviation
" {{{
" avoiding :w'
abbreviate w' w
" }}}

" --------------------------------------
" system
" {{{
set autoread
set nobackup
set noswapfile
set noundofile
set nowritebackup
" set shell=pwsh
set viewdir=~/.vim/view
set viewoptions-=options

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
set viewoptions-=options
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
if exists('&termguicolors')
  set termguicolors
endif
" }}}

" --------------------------------------
" source
" {{{
if filereadable(expand('~/.vim/rc/keymap.vim'))
  source ~/.vim/rc/keymap.vim
endif

if filereadable(expand('~/.vim/rc/autocmd.vim'))
  source ~/.vim/rc/autocmd.vim
endif

if filereadable(expand('~/.vim/rc/dein.vim'))
  source ~/.vim/rc/dein.vim
else
  filetype plugin indent on
  syntax enable
endif
" }}}

" --------------------------------------
" .vim directory layout
" {{{
" ~/.vim/init.vim
" ~/.vim/autoload/vimrc.vim
" ~/.vim/rc/autocmd.vim
" ~/.vim/rc/dein.vim
" ~/.vim/rc/dein_lazy.toml
" ~/.vim/rc/dein_lazy.toml
" ~/.vim/rc/dein_lazy_ddc.toml
" ~/.vim/rc/dein_nolazy.toml
" ~/.vim/rc/dein_nouse.toml
" ~/.vim/rc/keymap.vim
" ~/.vim/rc/local_sample.vim
" ~/.vim/snippets/markdown.snip
" }}}
