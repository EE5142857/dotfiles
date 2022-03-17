" TODO: ddc.vim
" TODO: ddu.vim
" TODO: diff
" TODO: git
" [.vim directory layout]
" ~/.vim/init.vim
" ~/.vim/rc/autocmd.vim
" ~/.vim/rc/dein.vim
" ~/.vim/rc/dein.toml
" ~/.vim/rc/dein_lazy.toml
" ~/.vim/rc/func.vim
set encoding=utf-8
scriptencoding utf-8

if has('unix')
  language messages C
else
  language messages en
endif

filetype off
filetype plugin indent off

" --------------------------------------
" source
"
if filereadable(fnamemodify('~/.vim/rc/autocmd.vim', ':p'))
  source ~/.vim/rc/func.vim
endif

if has('nvim')
  if filereadable(fnamemodify('~/.vim/rc/func.vim', ':p'))
    source ~/.vim/rc/func.vim
  endif

  if filereadable(fnamemodify('~/.vim/rc/dein.vim', ':p'))
    source ~/.vim/rc/dein.vim
  endif
endif

" --------------------------------------
" keymap
"
let g:mapleader="\<Space>"

nnoremap Q <Nop>
nnoremap q <Nop>
nnoremap j gj
nnoremap k gk
nnoremap gf gF
nnoremap Y y$
tnoremap <C-[> <C-\><C-n>

" Toggle wrap
nnoremap <silent> <Space>tw :set wrap!<CR>

" Encoding
nnoremap <silent> <Space>ec :edit ++encoding=cp932<CR>
nnoremap <silent> <Space>ee :edit ++encoding=euc-jp<CR>
nnoremap <silent> <Space>eu :edit ++encoding=utf-8<CR>

" .vimrc
nnoremap <silent> <Space>ei :tabedit ~/.vim/init.vim<CR>
nnoremap <silent> <Space>si :source ~/.vim/init.vim<CR>

" QuickFix
nnoremap <silent> <Space>k :cprevious<CR>
nnoremap <silent> <Space>j :cnext<CR>
nnoremap <silent> <Space>gg :<C-u>cfirst<CR>
nnoremap <silent> <Space>G :<C-u>clast<CR>

" Insert
inoremap ,date <C-r>=strftime('%Y-%m-%d %a')<CR>

" --------------------------------------
" system
"
set clipboard=unnamed
set nobackup
set noswapfile
set noundofile
set nowritebackup

" --------------------------------------
" edit
"
set autochdir
set autoread
" set binary noeol
set fileencodings=utf-8,cp932,euc-jp
set hidden
set isfname-=?
set nrformats=
set spelllang+=cjk spell

" --------------------------------------
" search
"
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
set cursorline
set display=lastline
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:»,precedes:«
set number
set pumheight=10
set showmatch matchtime=1
set wildmenu wildmode=list:longest

" --------------------------------------
" window
"
set noequalalways
set splitbelow
set splitright

" --------------------------------------
" statusline, tabline
"
set laststatus=2
set showtabline=2

" --------------------------------------
" indent
"
set autoindent
set expandtab
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

" for init.vim
setlocal shiftwidth=2 softtabstop=2 tabstop=2

" --------------------------------------
" variable
"
let g:netrw_home = '~/.vim'
let g:netrw_dirhistmax = 1
let g:vim_indent_cont = 0

" --------------------------------------
" end
"
filetype plugin indent on
syntax enable
