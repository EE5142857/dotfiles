if &compatible
  set nocompatible " Be iMproved
endif

if 0
  finish
endif

if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
  finish
end

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
source ~/.vim/dein/dein.vim

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

" Increase/decrease indent in a row
vnoremap << <gv
vnoremap >> >gv

" Encoding
nnoremap <silent> <Space>es :edit ++encoding=cp932<CR>
nnoremap <silent> <Space>eu :edit ++encoding=utf-8<CR>

" .vimrc
nnoremap <silent> <Space>ed :tabedit ~/.vim/dein/dein.toml<CR>
nnoremap <silent> <Space>ei :tabedit ~/.vim/init.vim<CR>
nnoremap <silent> <Space>si :source ~/.vim/init.vim<CR>

" Copy directory, file name and path
nnoremap <silent> <Space>cd :let @*=expand('%:p:h')<CR>
nnoremap <silent> <Space>cf :let @*=expand('%:t')<CR>
nnoremap <silent> <Space>cp :let @*=expand('%:p')<CR>

" Terminal
tnoremap <C-[> <C-\><C-n>

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

augroup ClearMarks
  autocmd!
  autocmd BufReadPost * delmarks!
  autocmd BufEnter * delmarks 0-9\"[]^.<>
augroup END

augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
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
" Indent
"
set autoindent
set expandtab
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

augroup MyFileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.css        setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.puml,*.pu  setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.vim        setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.toml       setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

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
  augroup NvimTerminal
    autocmd!
    autocmd TermOpen * startinsert
  augroup END
else
  command! -nargs=* T split | wincmd j | resize 5 | terminal ++curwin <args>
endif

command! -nargs=0 FixWhitespace call FixWhitespace()
function! FixWhitespace() abort
  execute '%s/\s\+$//e'
endfunction

command! -nargs=1 F call F(<f-args>)
function! F(word) abort
  execute 'vimgrep /' . a:word .'/g **/* | cw'
endfunction

" --------------------------------------
" Local Settings
"
"   Load settings for each location.
"   see (https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html)
"
"   local.vim
"     lcd <sfile>:h
"
"     let s:cwd = getcwd()
"
"     if !exists("g:dir_list")
"       let g:dir_list = [s:cwd]
"     else
"       for s:dir in g:dir_list
"         if s:dir == s:cwd
"           finish
"         endif
"       endfor
"
"       call add(g:dir_list, s:cwd)
"     endif
"
"     Silent ctags -R .
"
function! s:vimrc_local(loc)
  let l:files=findfile('local.vim', escape(a:loc, ' ') . ';', -1)
  for l:i in reverse(filter(l:files, 'filereadable(v:val)'))
    source `=l:i`
  endfor
endfunction

augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * lcd %:p:h
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
  autocmd WinEnter * pwd
augroup END
