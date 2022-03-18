" [.vim directory layout]
" ~/.vim/init.vim
" ~/.vim/rc/autocmd.vim
" ~/.vim/rc/dein.vim
" ~/.vim/rc/dein.toml
" ~/.vim/rc/dein_lazy.toml
" ~/.vim/rc/local_sample.vim
set encoding=utf-8
scriptencoding utf-8

if has('unix')
  language messages C
else
  language messages en
endif

filetype off
filetype plugin indent off
syntax off

" --------------------------------------
" variable
"
let g:netrw_home = '~/.vim'
let g:netrw_dirhistmax = 1
let g:vim_indent_cont = 0
if !exists('g:l_sourced_local_vimrc_path')
  let g:l_sourced_local_vimrc_path = []
endif

" --------------------------------------
" source
"
source ~/.vim/rc/autocmd.vim

if has('nvim')
  source ~/.vim/rc/dein.vim
endif

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

" resize window
nnoremap <S-Up>    <C-w>+
nnoremap <S-Down>  <C-w>-
nnoremap <S-Left>  <C-w>>
nnoremap <S-Right> <C-w><

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
nnoremap <silent> <Plug>(my-switch)s :<C-u>setl spell! spell?<CR>
nnoremap <silent> <Plug>(my-switch)l :<C-u>setl list! list?<CR>
nnoremap <silent> <Plug>(my-switch)t :<C-u>setl expandtab! expandtab?<CR>
nnoremap <silent> <Plug>(my-switch)w :<C-u>setl wrap! wrap?<CR>
nnoremap <silent> <Plug>(my-switch)p :<C-u>setl paste! paste?<CR>
nnoremap <silent> <Plug>(my-switch)b :<C-u>setl scrollbind! scrollbind?<CR>
nnoremap <silent> <Plug>(my-switch)y :call <SID>toggle_syntax()<CR>
function! s:toggle_syntax() abort
  if exists('g:syntax_on')
    syntax off
    redraw
    echo 'syntax off'
  else
    syntax on
    redraw
    echo 'syntax on'
  endif
endfunction

nnoremap <Plug>(my-edit) <Nop>
nmap <Leader>e <Plug>(my-edit)
nnoremap <silent> <Plug>(my-edit)i :tabedit ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)l :source ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)ec :edit ++encoding=cp932<CR>
nnoremap <silent> <Plug>(my-edit)ee :edit ++encoding=euc-jp<CR>
nnoremap <silent> <Plug>(my-edit)eu :edit ++encoding=utf-8<CR>

if has('nvim')
  nnoremap <Plug>(my-terminal) <Nop>
  nmap <Leader>t <Plug>(my-terminal)
  nnoremap <silent> <Plug>(my-terminal)s :call <SID>sp_terminal()<CR>
  nnoremap <silent> <Plug>(my-terminal)v :call <SID>vs_terminal()<CR>
  nnoremap <silent> <Plug>(my-terminal)i :call <SID>initialize()<CR>
  nnoremap <silent> <Plug>(my-terminal)e :call <SID>execute()<CR>

  function! s:vs_terminal() abort
    execute 'vsplit | terminal'
    execute 'wincmd h'
  endfunction

  function! s:sp_terminal() abort
    execute 'split | resize 5 | terminal'
    execute 'wincmd k'
  endfunction

  function! s:initialize() abort
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

  function! s:execute() abort
    if &filetype == 'python'
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
" simple command
" NOTE: vimgrep
"   :vimgrep /word/g **/*.*
" NOTE: argdo
"   :args **/*.*
"   :argdo %s/old/new/g | update
"   :argdo %s/old/new/gc | update
"   :argdelete *
command! -nargs=1 P execute 'let @* = @' . <q-args>
command! -nargs=1 G execute 'grep -ri ' . <q-args> . ' .'
command! -nargs=0 T execute '%s/\s\+$//e'
command! -nargs=1 Silent
\ execute 'silent !' . <q-args>
\|execute 'redraw!'

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
set autoread
" set binary noeol
set fileencodings=utf-8,cp932,euc-jp
set hidden
set nrformats=

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
set cursorline
set display=lastline
" set isfname-=|
set number
set pumheight=10
set showmatch matchtime=1
set spelllang+=cjk spell
set wildmenu wildmode=list:longest

" '␣': U+2423 Open Box
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:»,precedes:«

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
" colorscheme
"
if !has('nvim')
  set t_Co=256
  colorscheme industry
endif

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
" add path
"
" https://lambdalisue.hatenablog.com/entry/2015/12/25/000046
"
function! AddPath(path) abort
  if has('win32') || has ('win64')
    let l:path = $PATH . ";" . join(a:path, ";")
  endif
endfunction

" --------------------------------------
" end
"
filetype plugin indent on
syntax enable
