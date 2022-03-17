" TODO: ddc.vim
" TODO: ddu.vim
" TODO: diff
" TODO: git
" [.vim directory layout]
" ~/.vim/init.vim
" ~/.vim/rc/dein.vim
" ~/.vim/rc/dein_nvim.toml
" ~/.vim/rc/dein_nvim_lazy.toml
" ~/.vim/rc/dein_vim.toml
" ~/.vim/rc/dein_vim_lazy.toml
" ~/.vim/rc/func_nvim.vim
" ~/.vim/rc/local.vim
if 0
  finish " Skip initialization for vim-tiny or vim-small.
endif

if &compatible
  set nocompatible " Be iMproved
endif

language message C

" --------------------------------------
" Encoding
"
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,cp932

" --------------------------------------
" dein.vim
"
if filereadable(fnamemodify('~/.vim/rc/dein.vim', ':p'))
  source ~/.vim/rc/dein.vim
endif

" Required
filetype plugin indent on
syntax enable

" --------------------------------------
" func_nvim.vim
"
if filereadable(fnamemodify('~/.vim/rc/func_nvim.vim', ':p'))
  source ~/.vim/rc/func_nvim.vim
endif

" --------------------------------------
" loacl.vim
"
if filereadable(fnamemodify('~/.vim/rc/local.vim', ':p'))
  source ~/.vim/rc/local.vim
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
" Edit
"
" set binary noeol
set autochdir
set autoread
set clipboard=unnamed
set hidden
set isfname-=?
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
set display=lastline
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:»,precedes:«
set noequalalways
set number
set pumheight=10
set showmatch matchtime=1
set wildmenu wildmode=list:longest

" --------------------------------------
" Status Line
"
set laststatus=2
set showtabline=2

" --------------------------------------
" Spell
"
set spelllang+=cjk spell

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

  " File Type
  autocmd BufNewFile,BufRead *.ipynb setfiletype python
augroup END

" --------------------------------------
" Plugin
"
let g:netrw_home = '~/.vim'
let g:netrw_dirhistmax = 1

" vim: shiftwidth=2 softtabstop=2 tabstop=2:
