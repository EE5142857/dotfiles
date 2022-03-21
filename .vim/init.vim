" [.vim directory layout]
"   ~/.vim/init.vim
"   ~/.vim/autoload/vimrc.vim
"   ~/.vim/rc/autocmd.vim
"   ~/.vim/rc/dein_lazy.toml
"   ~/.vim/rc/dein_lazy_ddc.toml
"   ~/.vim/rc/dein_nolazy.toml
"   ~/.vim/rc/dein_nouse.toml
"   ~/.vim/rc/local_sample.vim
"   ~/.vim/snippets/markdown.snip
set encoding=utf-8
scriptencoding utf-8

if &compatible
  set nocompatible " Be iMproved
endif

language messages C

" --------------------------------------
" variable
"
let g:netrw_home = '~/.vim'
let g:netrw_dirhistmax = 1
let g:vim_indent_cont = 0

" --------------------------------------
" command
" NOTE: vimgrep
"   :vimgrep /word/g **/*.*
" NOTE: argdo
"   :args **/*.*
"   :argdo %s/old/new/g | update
"   :argdo %s/old/new/gc | update
"   :argdelete *
" NOTE: cdo
"   :cdo %s/old/new/g | update
"   :cdo %s/old/new/gc | update
command! -nargs=1 P execute 'let @* = @' . <q-args>
command! -nargs=1 G execute 'grep -ri ' . <q-args> . ' .'
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'

" --------------------------------------
" keymap
"
let g:mapleader="\<Space>"

nnoremap Q <Nop>
nnoremap q <Nop>
nnoremap Y y$
nnoremap j gj
nnoremap k gk
nnoremap gf <C-w>gF
tnoremap <C-[> <C-\><C-n>

" delete
vnoremap d "_d
nnoremap d "_d
vnoremap D "_D
nnoremap D "_D
vnoremap x "_x
nnoremap x "_x
vnoremap s "_s
nnoremap s "_s

" cut
nnoremap t d
vnoremap t x
nnoremap tt dd
nnoremap T D

" quickfix
nnoremap <silent> <Leader>k :cprevious<CR>
nnoremap <silent> <Leader>j :cnext<CR>
nnoremap <silent> <Leader>gg :<C-u>cfirst<CR>
nnoremap <silent> <Leader>G :<C-u>clast<CR>

" insert
inoremap ,date <C-r>=strftime('%Y-%m-%d %a')<CR>

" https://lambdalisue.hatenablog.com/entry/2015/12/25/000046
nnoremap <Plug>(my-switch) <Nop>
nmap <Leader>s <Plug>(my-switch)
nnoremap <silent> <Plug>(my-switch)b :<C-u>setlocal scrollbind! scrollbind?<CR>
nnoremap <silent> <Plug>(my-switch)l :<C-u>setlocal list! list?<CR>
nnoremap <silent> <Plug>(my-switch)p :<C-u>setlocal paste! paste?<CR>
nnoremap <silent> <Plug>(my-switch)s :<C-u>setlocal spell! spell?<CR>
nnoremap <silent> <Plug>(my-switch)t :<C-u>setlocal expandtab! expandtab?<CR>
nnoremap <silent> <Plug>(my-switch)w :<C-u>setlocal wrap! wrap?<CR>

nnoremap <Plug>(my-edit) <Nop>
nmap <Leader>e <Plug>(my-edit)
nnoremap <silent> <Plug>(my-edit)ec :edit ++encoding=cp932<CR>
nnoremap <silent> <Plug>(my-edit)ee :edit ++encoding=euc-jp<CR>
nnoremap <silent> <Plug>(my-edit)eu :edit ++encoding=utf-8<CR>
nnoremap <silent> <Plug>(my-edit)ie :tabedit ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)is :source ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)t :%s/\s\+$//e<CR>

if has('nvim')
  nnoremap <Plug>(my-terminal) <Nop>
  nmap <Leader>t <Plug>(my-terminal)
  nnoremap <silent> <Plug>(my-terminal)sp :call <SID>t_sp()<CR>
  nnoremap <silent> <Plug>(my-terminal)vs :call <SID>t_vs()<CR>
  nnoremap <silent> <Plug>(my-terminal)su :call <SID>t_setup()<CR>
  nnoremap <silent> <Plug>(my-terminal)e :call <SID>t_execute()<CR>

  function! s:t_sp() abort
    split
    resize 5
    terminal
    wincmd k
  endfunction

  function! s:t_vs() abort
    vsplit
    terminal
    wincmd h
  endfunction

  function! s:t_setup() abort
    if fnamemodify(@%, ':e') == 'ipynb'
      call StartJupyter()
    elseif &filetype == 'python'
      call StartPython()
    elseif &filetype == 'sql'
      call StartSQL()
    else
      echo 'unavailavle'
    endif
  endfunction

  function! s:t_execute() abort
    if fnamemodify(@%, ':e') == 'ipynb'
      call ExecuteJupyter()
    elseif &filetype == 'python'
      call ExecutePython()
    elseif &filetype == 'sql'
      call ExecuteSQL()
    elseif &filetype == 'r'
      call ExecuteR()
    else
      echo 'unavailavle'
    endif
  endfunction
endif

" --------------------------------------
" system
"
set nobackup
set noswapfile
set noundofile
set nowritebackup

if has('win32') || has('win64') || has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" --------------------------------------
" edit
"
set autoread
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

" --------------------------------------
" search
"
set grepprg=grep\ -n
set hlsearch
set ignorecase
set incsearch
set shortmess-=S
set smartcase
set wrapscan

" --------------------------------------
" view
"
set ambiwidth=double
set display=lastline
set number

" --------------------------------------
" wildmenu
" pum
"
set pumheight=10
set wildmenu wildmode=list:longest

if has('nvim')
  set pumblend=30
endif

" --------------------------------------
" window
"
set noequalalways
set splitbelow
set splitright

" --------------------------------------
" status line
" tab line
" command line
"
set laststatus=2
set showtabline=2
set cmdheight=2

" --------------------------------------
" highlight
"
set cursorline
set showmatch matchtime=1
set spelllang+=cjk spell

" '␣': U+2423 Open Box
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:»,precedes:«

" --------------------------------------
" filetype-global setting
"
set autoindent
set expandtab
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

" --------------------------------------
" color
"
if exists('&termguicolors')
  set termguicolors
endif

" --------------------------------------
" source
"
source ~/.vim/rc/autocmd.vim

" --------------------------------------
" dein.vim
"
" https://github.com/Shougo/dein.vim
" https://knowledge.sakura.ad.jp/23248/
" https://github.com/Shougo/shougo-s-github/blob/master/vim/rc/vimrc
"
" In Windows, auto_recache is disabled.  It is too slow.
let g:dein#auto_recache = !(has('win32') || has('win64'))

let g:dein#lazy_rplugins = v:true
let g:dein#install_progress_type = 'floating'

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

if dein#min#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:base_dir = expand('~/.vim/rc') . '/'
  let s:toml_nolazy   = s:base_dir . 'dein_nolazy.toml'
  let s:toml_lazy     = s:base_dir . 'dein_lazy.toml'
  let s:toml_lazy_ddc = s:base_dir . 'dein_lazy_ddc.toml'

  call dein#load_toml(s:toml_nolazy,    {'lazy': 0})
  call dein#load_toml(s:toml_lazy,      {'lazy': 1})
  call dein#load_toml(s:toml_lazy_ddc,  {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" Required
filetype plugin indent on
syntax enable

call dein#call_hook('source')
