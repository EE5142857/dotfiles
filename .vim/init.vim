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
" option
" {{{
" system {{{
set autoread
set nobackup
set noswapfile
set noundofile
set nowritebackup
if has('win32') || has('win64') || has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif
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
set grepprg=grep\ -n
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
set title titlestring=Vim
set pumheight=10
set wildmenu wildmode=list:longest
if has('nvim')
  set pumblend=30
endif
set laststatus=2
set showtabline=2
set cmdheight=2
set noequalalways
set splitbelow
set splitright
" }}}

" highlight {{{
set cursorline
set showmatch matchtime=1
" '␣': U+2423 Open Box
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:»,precedes:«
if &diff
  set nospell
else
  set spelllang+=cjk spell
endif
" }}}

" color {{{
set t_Co=256
if exists('&termguicolors')
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
  autocmd FileType * call vimrc#ft_common()
  autocmd FileType css,mermaid,plantuml,toml,vim call vimrc#ft_sw2()

  " syntax
  autocmd Colorscheme,Syntax * call vimrc#syntax()

  " mark
  autocmd BufReadPost * call vimrc#restore_cursor()
  autocmd BufReadPost * delmarks a-z
  autocmd VimLeavePre * delmarks a-z0-9[]^.<>

  " register
  autocmd BufEnter *    call vimrc#update_register()
  autocmd VimLeavePre * call vimrc#delete_register()

  " local.vim
  " https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
  autocmd BufNewFile,BufReadPost,BufEnter * call vimrc#source_local_vimrc(expand('<afile>'))
augroup END
" }}}

" --------------------------------------
" dein.vim
" {{{
if 0
  filetype plugin indent on
  syntax enable

  colorscheme desert
  " colorscheme evening
else
  if &runtimepath !~# '/dein.vim'
    if has('nvim')
      let s:dein_dir = expand('~/.cache/nvim/dein')
    else
      let s:dein_dir = expand('~/.cache/vim/dein')
    endif
    let s:dein_repo_dir = s:dein_dir.'/repos/github.com/Shougo/dein.vim'

    if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath+=' . s:dein_repo_dir
  endif

  let g:dein#install_check_diff = v:true
  let g:dein#install_progress_type = 'floating'
  let g:dein#lazy_rplugins = v:true
  " let g:dein#inline_vimrcs = split(glob("~/.vim/rc/*.vim"), "\n")

  if dein#min#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:rc_dir = substitute(expand('~/.vim/rc'), '\\', '\/', 'g') . '/'
    call dein#load_toml(s:rc_dir . 'dein_nolazy.toml',      {'lazy': 0})
    call dein#load_toml(s:rc_dir . 'dein_lazy.toml',        {'lazy': 1})
    call dein#load_toml(s:rc_dir . 'dein_lazy_ddc.toml',    {'lazy': 1})
    call dein#load_toml(s:rc_dir . 'dein_lazy_ddu.toml',    {'lazy': 1})

    call dein#end()
    call dein#save_state()
  endif

  " call dein#update()

  if dein#check_install()
    call dein#install()
  endif

  " Required
  filetype plugin indent on
  syntax enable

  call dein#call_hook('source')
endif
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
" keymap
" {{{
nnoremap Q <Nop>
nnoremap q <Nop>
nnoremap Y y$
nnoremap j gj
nnoremap k gk
nnoremap gf gF
tnoremap <C-[> <C-\><C-n>
tnoremap <CR> <CR><C-\><C-n>

let g:mapleader="\<Space>"

" quickfix
nnoremap <silent> <Leader>k   <Cmd>cprevious<CR>
nnoremap <silent> <Leader>j   <Cmd>cnext<CR>
nnoremap <silent> <Leader>gg  <Cmd><C-u>cfirst<CR>
nnoremap <silent> <Leader>G   <Cmd><C-u>clast<CR>

" insert
inoremap ,date <C-r>=strftime('%Y-%m-%d %a')<CR>

" https://lambdalisue.hatenablog.com/entry/2015/12/25/000046
nnoremap <Plug>(my-switch) <Nop>
nmap <Leader>s <Plug>(my-switch)
nnoremap <silent> <Plug>(my-switch)b  <Cmd><C-u>setlocal scrollbind! scrollbind?<CR>
nnoremap <silent> <Plug>(my-switch)l  <Cmd><C-u>setlocal list! list?<CR>
nnoremap <silent> <Plug>(my-switch)p  <Cmd><C-u>setlocal paste! paste?<CR>
nnoremap <silent> <Plug>(my-switch)s  <Cmd><C-u>setlocal spell! spell?<CR>
nnoremap <silent> <Plug>(my-switch)t  <Cmd><C-u>setlocal expandtab! expandtab?<CR>
nnoremap <silent> <Plug>(my-switch)w  <Cmd><C-u>setlocal wrap! wrap?<CR>

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
" nnoremap <silent> <Plug>(my-filer)t   <Cmd>15Lexplore<CR>

nnoremap <Plug>(my-terminal) <Nop>
nmap <Leader>t <Plug>(my-terminal)

nnoremap <Plug>(my-ddu) <Nop>
nmap <Leader>u <Plug>(my-ddu)
" }}}


" --------------------------------------
" local setting
" {{{
if filereadable(expand('~/.vim/local_sample.vim'))
  source ~/.vim/local_sample.vim
endif
" }}}

" --------------------------------------
" .vim directory layout
" {{{
" ~/.vim/init.vim
" ~/.vim/autoload/vimrc.vim
" ~/.vim/ftdetect/my_filetype.vim
" ~/.vim/rc/dein_lazy.toml
" ~/.vim/rc/dein_lazy_ddc.toml
" ~/.vim/rc/dein_lazy_ddu.toml
" ~/.vim/rc/dein_nolazy.toml
" ~/.vim/rc/local_sample.vim
" ~/.vim/snippets/markdown.snip
" }}}

" vim: foldmethod=marker
