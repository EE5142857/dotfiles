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
if 0
  let g:loaded_netrwPlugin = 1
else
  let g:netrw_banner = 0
  let g:netrw_browse_split = 0
  let g:netrw_dirhistmax = 1
  let g:netrw_hide = 0
  let g:netrw_home = '~/.vim'
  let g:netrw_liststyle = 0
endif
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
set fileformat=dos
set fileformats=dos,unix,mac
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
if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l:%c:%m
endif
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
set wildmenu wildmode=list:longest
if !has('nvim')
  set title titlestring=Vim
endif
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
set tabline=%!vimrc#tabline()
set showtabline=2
set statusline=%!vimrc#statusline()
set fillchars=stl:\ ,stlnc:\_
set laststatus=2
set noshowmode
" }}}

" highlight {{{
set cursorline
set showmatch matchtime=1 matchpairs+=\<:\>
" space:\\u2423,extends:\\u00BB,precedes:\\u00AB
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
  autocmd FileType css,mermaid,plantuml,sh,toml,vim
    \ setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType markdown
    \ highlight link markdownError Normal

  " highlight
  " autocmd ColorScheme * call vimrc#highlight()

  " syntax
  autocmd Syntax,BufEnter * call vimrc#syntax()

  " mark
  autocmd BufReadPost * call vimrc#restore_cursor()
  autocmd BufReadPost * delmarks a-z
  autocmd VimLeavePre * delmarks a-z0-9[]^.<>

  " register
  autocmd BufEnter * call vimrc#update_register()
  autocmd VimLeavePre * call vimrc#delete_register()

  " autoread
  autocmd WinEnter * checktime

  " TODO: TextYankPost

  " local.vim
  " https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
  autocmd BufNewFile,BufReadPost,BufEnter * call vimrc#source_local_vimrc(expand('<afile>'))
augroup END
" }}}

" --------------------------------------
" dein.vim
" {{{
if filereadable(expand('~/.vim/rc/dein.vim')) && !has('unix')
  source ~/.vim/rc/dein.vim
endif

filetype plugin indent on
syntax enable

colorscheme desert
" colorscheme evening

if exists("*dein#call_hook")
  call dein#call_hook('source')
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
"NOTE: comment & uncomment
  " f,e:norm i"
  " f,e:norm x
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
nnoremap <Esc><Esc> <Cmd>nohlsearch<CR>

vnoremap j gj
vnoremap k gk

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
else
  set termwinkey=<C-g>
  tnoremap <Esc> <C-g>N
endif

nnoremap <S-Down> <C-w>1-
nnoremap <S-Up> <C-w>1+
nnoremap <S-Right> <C-w>10>
nnoremap <S-Left> <C-w>10<

let g:mapleader="\<Space>"

" quickfix
nnoremap <silent> <Leader>k   <Cmd>cprevious<CR>
nnoremap <silent> <Leader>j   <Cmd>cnext<CR>
nnoremap <silent> <Leader>gg  <Cmd>cfirst<CR>
nnoremap <silent> <Leader>G   <Cmd>clast<CR>

" insert
inoremap ,date <C-r>=strftime('%Y-%m-%d')<CR>

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
nnoremap <silent> <Plug>(my-edit)fec  <Cmd>setlocal fileencoding=cp932<CR>
nnoremap <silent> <Plug>(my-edit)fee  <Cmd>setlocal fileencoding=euc-jp<CR>
nnoremap <silent> <Plug>(my-edit)feu  <Cmd>setlocal fileencoding=utf-8<CR>
nnoremap <silent> <Plug>(my-edit)ffd  <Cmd>edit ++fileformat=dos<CR>
nnoremap <silent> <Plug>(my-edit)ffm  <Cmd>edit ++fileformat=mac<CR>
nnoremap <silent> <Plug>(my-edit)ffu  <Cmd>edit ++fileformat=unix<CR>
nnoremap <silent> <Plug>(my-edit)i    <Cmd>edit ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)t    <Cmd>%s/\s\+$//e<CR>

nnoremap <Plug>(my-filer) <Nop>
nmap <Leader>f <Plug>(my-filer)
nnoremap <silent> <Plug>(my-filer)b   <Cmd>edit ~/Desktop/p/bookmark.md<CR>
nnoremap <silent> <Plug>(my-filer)t   <Cmd>15Lexplore<CR>

nnoremap <Plug>(my-terminal) <Nop>
nmap <Leader>t <Plug>(my-terminal)
if has('unix')
  nnoremap <silent> <Plug>(my-terminal)oh   <Cmd>call vimrc#split(v:count)<CR>
  nnoremap <silent> <Plug>(my-terminal)ov   <Cmd>call vimrc#vsplit()<CR>
  nnoremap <silent> <Plug>(my-terminal)emm  <Cmd>call vimrc#send_cmd("mmdc -i " . fnamemodify(@%, ':t') . " -o " . fnamemodify(@%, ':t:r') . ".svg && mmdc -i " . fnamemodify(@%, ':t') . " -o " . fnamemodify(@%, ':t:r') . ".png")<CR>
  nnoremap <silent> <Plug>(my-terminal)epu  <Cmd>call vimrc#send_cmd("java -jar " . g:my_plantuml_path . " " . fnamemodify(@%, ':p') . " -charset UTF-8 -svg && java -jar " . g:my_plantuml_path . fnamemodify(@%, ':p') . " -charset UTF-8 -png"<CR>
  nnoremap <silent> <Plug>(my-terminal)srs  <Cmd>call vimrc#send_cmd("r")<CR>
  nnoremap <silent> <Plug>(my-terminal)ssq  <Cmd>call vimrc#send_cmd("pg_ctl start && psql -U postgres -d recipe")<CR>
  nnoremap <silent> <Plug>(my-terminal)rpy  <Cmd>call vimrc#send_cmd("python " . @a)<CR>
  nnoremap <silent> <Plug>(my-terminal)rrs  <Cmd>call vimrc#send_cmd("rscript --encoding=utf-8 " . @a)<CR>
  nnoremap <silent> <Plug>(my-terminal)rsq  <Cmd>call vimrc#send_cmd("\i " . @a)<CR>
endif

nnoremap <Plug>(my-ddu) <Nop>
nmap <Leader>u <Plug>(my-ddu)
" }}}

" --------------------------------------
" .vim directory layout
" {{{
" ~/.vim/ginit.vim
" ~/.vim/init.vim
" ~/.vim/local_sample.vim
" ~/.vim/autoload
" ~/.vim/ftdetect
" ~/.vim/rc
" ~/.vim/vsnip
" }}}

" vim: foldmethod=marker nofoldenable
