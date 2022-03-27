" --------------------------------------
" essential
" {{{
if &compatible
  set nocompatible " Be iMproved
endif

set encoding=utf-8
scriptencoding utf-8

language messages C

filetype off
filetype plugin indent off
syntax off
" }}}

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
  autocmd FileType css,mermaid,plantuml,toml call vimrc#ft_sw2()

  " *.vim
  autocmd BufEnter *.vim call vimrc#ft_vim()

  " syntax
  autocmd Syntax * call vimrc#syntax()

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
if filereadable(expand('~/.vim/rc/dein.vim'))
  source ~/.vim/rc/dein.vim
else
  filetype plugin indent on
  syntax enable

  colorscheme desert
  " colorscheme evening
endif
" }}}

" --------------------------------------
" highlight
" {{{
highlight CursorLine  cterm=NONE ctermfg=NONE ctermbg=NONE
highlight CursorLine  gui=NONE guifg=NONE guibg=NONE
highlight Folded      cterm=NONE ctermfg=DarkGray ctermbg=NONE
highlight Folded      gui=NONE guifg=DarkGray guibg=NONE
highlight SpecialKey  cterm=NONE ctermfg=DarkGray ctermbg=NONE
highlight SpecialKey  gui=NONE guifg=DarkGray guibg=NONE
if has('nvim')
  highlight Whitespace  cterm=NONE ctermfg=DarkGray ctermbg=NONE
  highlight Whitespace  gui=NONE guifg=DarkGray guibg=NONE
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
nnoremap Y y$
nnoremap j gj
nnoremap k gk
nnoremap gf gF
tnoremap <C-[> <C-\><C-n>
tnoremap <CR> <CR><C-\><C-n>

let g:mapleader="\<Space>"

" quickfix
nnoremap <silent> <Leader>k   :cprevious<CR>
nnoremap <silent> <Leader>j   :cnext<CR>
nnoremap <silent> <Leader>gg  :<C-u>cfirst<CR>
nnoremap <silent> <Leader>G   :<C-u>clast<CR>

" insert
inoremap ,date <C-r>=strftime('%Y-%m-%d %a')<CR>

" https://lambdalisue.hatenablog.com/entry/2015/12/25/000046
nnoremap <Plug>(my-switch) <Nop>
nmap <Leader>s <Plug>(my-switch)
nnoremap <silent> <Plug>(my-switch)b  :<C-u>setlocal scrollbind! scrollbind?<CR>
nnoremap <silent> <Plug>(my-switch)l  :<C-u>setlocal list! list?<CR>
nnoremap <silent> <Plug>(my-switch)p  :<C-u>setlocal paste! paste?<CR>
nnoremap <silent> <Plug>(my-switch)s  :<C-u>setlocal spell! spell?<CR>
nnoremap <silent> <Plug>(my-switch)t  :<C-u>setlocal expandtab! expandtab?<CR>
nnoremap <silent> <Plug>(my-switch)w  :<C-u>setlocal wrap! wrap?<CR>

nnoremap <Plug>(my-edit) <Nop>
nmap <Leader>e <Plug>(my-edit)
nnoremap <silent> <Plug>(my-edit)ec   :edit ++encoding=cp932<CR>
nnoremap <silent> <Plug>(my-edit)ee   :edit ++encoding=euc-jp<CR>
nnoremap <silent> <Plug>(my-edit)eu   :edit ++encoding=utf-8<CR>
nnoremap <silent> <Plug>(my-edit)i    :edit ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)t    :%s/\s\+$//e<CR>

nnoremap <Plug>(my-filer) <Nop>
nmap <Leader>f <Plug>(my-filer)
nnoremap <silent> <Plug>(my-filer)b   :edit ~/Desktop/bookmark.md<CR>
" nnoremap <silent> <Plug>(my-filer)t   :15Lexplore<CR>

nnoremap <Plug>(my-terminal) <Nop>
nmap <Leader>t <Plug>(my-terminal)
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
" ~/.vim/local_sample.vim
" ~/.vim/autoload/vimrc.vim
" ~/.vim/ftdetect/my_filetype.vim
" ~/.vim/rc/dein.vim
" ~/.vim/rc/dein_lazy.toml
" ~/.vim/rc/dein_lazy_ddc.toml
" ~/.vim/rc/dein_nolazy.toml
" ~/.vim/snippets/markdown.snip
" }}}
