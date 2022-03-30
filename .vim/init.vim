if &compatible
  set nocompatible " Be iMproved
endif

set encoding=utf-8
scriptencoding utf-8

language messages C

filetype off
filetype plugin indent off
syntax off

" --------------------------------------
" variable
" {{{
let g:loaded_netrwPlugin = 1
let g:netrw_dirhistmax = 1
let g:netrw_home = '~/.vim'
let g:vim_indent_cont = 0
" }}}

" --------------------------------------
" option
" {{{
" system {{{
set autoread
set clipboard=unnamed
set nobackup
set noswapfile
set noundofile
set nowritebackup
" }}}

" edit {{{
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

" search {{{
set grepprg=grep
set hlsearch
set ignorecase
set incsearch
set shortmess-=S
set smartcase
set wrapscan
" }}}

" view {{{
set ambiwidth=double
set display=lastline
set number
" }}}

" window {{{
if !has('nvim')
  set title titlestring=Vim
endif
set wildmenu wildmode=list:longest
set pumheight=10
if has('nvim')
  set pumblend=30
endif
set noequalalways
set splitbelow
set splitright
" }}}

" commandline tabline statusline {{{
set cmdheight=2
set showtabline=2
set fillchars=stl:\ ,stlnc:\_
set laststatus=2
set noshowmode
" }}}

" highlight {{{
set cursorline
set showmatch matchtime=1 matchpairs+=\<:\>
" '␣': U+2423 Open Box
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:»,precedes:«
if &diff
  set nospell
else
  set spelllang+=cjk spell
endif
" }}}

" color {{{
if has('termguicolors')
  set termguicolors
endif
" }}}

" abbreviation {{{
" avoiding :w'
cnoreabbrev w' w
" }}}
" }}}

" --------------------------------------
" autocmd
" {{{
augroup MyAutocmd
  autocmd!
  " filetype (order-sensitive)
  autocmd BufNewFile,BufRead *
    \ if empty(&filetype)
    \|  call vimrc#ft_common()
    \|endif
  autocmd FileType *
    \ call vimrc#ft_common()
  autocmd FileType css,mermaid,plantuml,toml,vim
    \ setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType snippet
    \ setlocal noexpandtab

  " highlight
  autocmd Colorscheme *
    \ call vimrc#highlight()
    \|set statusline=%!vimrc#statusline()
    \|set tabline=%!vimrc#tabline()

  " syntax
  autocmd Syntax * call vimrc#syntax()

  " mark
  autocmd BufReadPost * call vimrc#restore_cursor()
  autocmd BufReadPost * delmarks a-z
  autocmd VimLeavePre * delmarks a-z0-9[]^.<>

  " register
  autocmd BufEnter * call vimrc#update_register()
  autocmd VimLeavePre * call vimrc#delete_register()

  " autoread
  autocmd WinEnter * checktime

  " local.vim
  " https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
  autocmd BufNewFile,BufReadPost,BufEnter * call vimrc#source_local_vimrc(expand('<afile>'))
augroup END
" }}}

" --------------------------------------
" dein.vim
" {{{
if 1
  if filereadable(expand('~/.vim/rc/dein.vim'))
    source ~/.vim/rc/dein.vim
  endif
else
  filetype plugin indent on
  syntax enable

  colorscheme default
  " colorscheme desert
  " colorscheme evening
endif
" }}}

" --------------------------------------
" command
" {{{
" NOTE: grep
" " :grep -nri word .
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
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'
" }}}

" --------------------------------------
" keymap
" {{{
nnoremap Q <Nop>
nnoremap q <Nop>
nnoremap Y y$
nnoremap j gj
nnoremap k gk
nnoremap gf gF
tnoremap <Esc> <C-\><C-n>
tnoremap <CR> <CR><C-\><C-n>

let g:mapleader="\<Space>"

" quickfix
nnoremap <silent> <Leader>k   <Cmd>cprevious<CR>
nnoremap <silent> <Leader>j   <Cmd>cnext<CR>
nnoremap <silent> <Leader>gg  <Cmd>cfirst<CR>
nnoremap <silent> <Leader>G   <Cmd>clast<CR>

" insert
inoremap ,date <C-r>=strftime('%Y-%m-%d %a')<CR>

" https://lambdalisue.hatenablog.com/entry/2015/12/25/000046
nnoremap <Plug>(my-switch) <Nop>
nmap <Leader>s <Plug>(my-switch)
nnoremap <silent> <Plug>(my-switch)b  <Cmd>setlocal scrollbind! scrollbind?<CR>
nnoremap <silent> <Plug>(my-switch)l  <Cmd>setlocal list! list?<CR>
nnoremap <silent> <Plug>(my-switch)p  <Cmd>setlocal paste! paste?<CR>
nnoremap <silent> <Plug>(my-switch)s  <Cmd>setlocal spell! spell?<CR>
nnoremap <silent> <Plug>(my-switch)t  <Cmd>setlocal expandtab! expandtab?<CR>
nnoremap <silent> <Plug>(my-switch)w  <Cmd>setlocal wrap! wrap?<CR>

nnoremap <Plug>(my-edit) <Nop>
nmap <Leader>e <Plug>(my-edit)
nnoremap <silent> <Plug>(my-edit)ec   <Cmd>edit ++encoding=cp932<CR>
nnoremap <silent> <Plug>(my-edit)ee   <Cmd>edit ++encoding=euc-jp<CR>
nnoremap <silent> <Plug>(my-edit)eu   <Cmd>edit ++encoding=utf-8<CR>
nnoremap <silent> <Plug>(my-edit)i    <Cmd>edit ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)t    <Cmd>%s/\s\+$//e<CR>

nnoremap <Plug>(my-filer) <Nop>
nmap <Leader>f <Plug>(my-filer)
nnoremap <silent> <Plug>(my-filer)b   <Cmd>edit ~/Desktop/bookmark.md<CR>
nnoremap <silent> <Plug>(my-filer)n   <Cmd>edit ~/Desktop/n.md<CR>

nnoremap <Plug>(my-terminal) <Nop>
nmap <Leader>t <Plug>(my-terminal)

nnoremap <Plug>(my-ddu) <Nop>
nmap <Leader>u <Plug>(my-ddu)
" }}}

" --------------------------------------
" local setting
" {{{
if filereadable(expand('~/.vim/rc/local_sample.vim'))
  source ~/.vim/rc/local_sample.vim
endif
" }}}

" --------------------------------------
" .vim directory layout
" {{{
" ~/.vim/ginit.vim
" ~/.vim/init.vim
" ~/.vim/autoload/vimrc.vim
" ~/.vim/ftdetect/my_filetype.vim
" ~/.vim/rc/dein.vim
" ~/.vim/rc/dein_lazy.toml
" ~/.vim/rc/dein_lazy_ddc.toml
" ~/.vim/rc/dein_lazy_ddu.toml
" ~/.vim/rc/dein_nolazy.toml
" ~/.vim/rc/dein_nouse.toml
" ~/.vim/rc/local_sample.vim
" ~/.vim/snippets/markdown.snip
" }}}

" vim: foldmethod=marker nofoldenable
