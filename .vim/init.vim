if &compatible
  set nocompatible " Be iMproved
endif

if 0
  finish
endif

" if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
"   finish
" end

" --------------------------------------
" Encoding
"
" $LANG=en_US/CP932
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,cp932

" --------------------------------------
" dein.vim
"
execute 'source' fnamemodify('~/.vim/dein/dein.vim', ':p')

" Required:
filetype plugin indent on
syntax enable

" --------------------------------------
" Keymap
"
let g:mapleader="\<Space>"

nnoremap Q <Nop>
nnoremap q <Nop>

nnoremap j gj
nnoremap k gk

nnoremap gf gF

" Toggle wrap
nnoremap <silent> <Space>tw :set wrap!<CR>

" Encoding
nnoremap <silent> <Space>es :edit ++encoding=cp932<CR>
nnoremap <silent> <Space>eu :edit ++encoding=utf-8<CR>

" .vimrc
nnoremap <silent> <Space>ed1 :tabedit ~/.vim/dein/dein.toml<CR>
nnoremap <silent> <Space>ed2 :tabedit ~/.vim/dein/dein_lazy.toml<CR>
nnoremap <silent> <Space>ed3 :tabedit ~/.vim/dein/dein_nvim.toml<CR>
nnoremap <silent> <Space>ed4 :tabedit ~/.vim/dein/dein_nvim_lazy.toml<CR>
nnoremap <silent> <Space>ei :tabedit ~/.vim/init.vim<CR>
nnoremap <silent> <Space>si :source ~/.vim/init.vim<CR>

" Copy directory, file name and path
nnoremap <silent> <Space>cd :let @*=expand('%:p:h')<CR>
nnoremap <silent> <Space>cf :let @*=expand('%:t')<CR>
nnoremap <silent> <Space>cp :let @*=expand('%:p')<CR>

" Terminal
tnoremap <C-[> <C-\><C-n>

inoremap ,date <C-R>=strftime('%Y-%m-%d %a')<CR>

" --------------------------------------
" Edit
"
set autoread
set clipboard=unnamed
set hidden
set isfname-=#
set nobackup
set noswapfile
set noundofile
set nowritebackup
set nrformats=

augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
augroup END

augroup ClearMarks
  autocmd!
  autocmd BufReadPost * delmarks!
  autocmd BufEnter * delmarks 0-9\"[]^.<>
augroup END

augroup UpdateRegisters
  autocmd!
  autocmd BufEnter * let @x=expand('%:t')
  autocmd BufEnter * let @y=expand('%:p:h')
  autocmd BufEnter * let @z=expand('%:p')
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
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:>,precedes:<
set noequalalways
set number
set showmatch
set showtabline=2
set wildmenu wildmode=list:longest

" --------------------------------------
" Status Line
"
set laststatus=2
set noshowmode
set ruler

" --------------------------------------
" Color Scheme
"
" default dark color schemes
" colorscheme desert
" colorscheme elflord
" colorscheme industry
" colorscheme pablo

" default dark color schemes I won't set
" colorscheme blue
" colorscheme darkblue
" colorscheme default
" colorscheme delek
" colorscheme koehler
" colorscheme murphy
" colorscheme peachpuff
" colorscheme ron
" colorscheme slate
" colorscheme torte
" colorscheme zellner

" default light color schemes
" colorscheme evening
" colorscheme morning
" colorscheme shine

" --------------------------------------
" Spell
"
set spelllang+=cjk
set spell

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
  autocmd BufNewFile,BufRead *.css        setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.puml,*.pu  setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.vim        setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.toml       setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

" --------------------------------------
" Plugin
"
let g:netrw_home='~/.vim'
let g:netrw_dirhistmax=1

" --------------------------------------
" Function
"
" TODO: is <args>?
command! -nargs=1 Silent
\ execute 'silent !' . <q-args>
\ | execute 'redraw!'

if has('nvim')
  command! -nargs=* T split | wincmd j | resize 5 | terminal <args>
  command! -nargs=* VT vsplit | wincmd l | terminal <args>
else
  command! -nargs=* T split | wincmd j | resize 5 | terminal ++curwin <args>
  command! -nargs=* VT vsplit | wincmd l | terminal ++curwin <args>
endif

command! -nargs=0 FixWhitespace call FixWhitespace()
function! FixWhitespace() abort
  execute '%s/\s\+$//e'
endfunction

command! -nargs=1 F call F(<f-args>)
function! F(word) abort
  execute 'vimgrep /' . a:word . '/g **/* | cw'
endfunction

" --------------------------------------
" Local Settings
"
"   Load settings for each location.
"
" TODO: 統合する
"   local.vim
"     lcd <sfile>:p:h
"
"     if index(g:cwd_list, fnamemodify(getcwd(), ':p:h')) < 0
"       Silent ctags -R .
"     endif
"
"     let g:python3_host_prog = 'C:\work\myenv\Scripts\python.exe'
"
if !exists('g:cwd_list')
  let g:cwd_list = []
endif

function! s:SourceLocalVimrc(path)
  execute 'lcd' fnamemodify(a:path, ':p:h')
  let l:rpath_list = findfile('local.vim', escape(a:path, ' ') . ';', -1)

  for l:i in reverse(filter(l:rpath_list, 'filereadable(v:val)'))
    let l:dir = fnamemodify(l:i, ':p:h')
    let l:path = fnamemodify(l:i, ':p')
    execute 'source' l:path

    if index(g:cwd_list, l:dir) < 0
      call add(g:cwd_list, l:dir)
    endif
  endfor
endfunction

augroup MyLocalVimrc
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:SourceLocalVimrc(expand('<afile>:p:h'))
augroup END
