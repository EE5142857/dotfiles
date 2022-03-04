if &compatible
  set nocompatible " Be iMproved
endif

if 0
  finish
endif

" --------------------------------------
" Encoding
"
" $LANG = en_US/CP932
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
let mapleader = " "

nnoremap Q <Nop>
nnoremap q <Nop>

nnoremap j gj
nnoremap k gk

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
nnoremap <silent> <Space>cd :let @* = expand('%:p:h')<CR>
nnoremap <silent> <Space>cf :let @* = expand('%:t')<CR>
nnoremap <silent> <Space>cp :let @* = expand('%:p')<CR>

" see (https://github.com/Shougo/neosnippet.vim)
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" see (https://github.com/plasticboy/vim-markdown)
nnoremap <silent> <Space>tf :TableFormat<CR>

" --------------------------------------
" Plugin
"
" see (https://github.com/Shougo/neosnippet.vim)
" let g:neosnippet#snippets_directory = '~/.vim/snippets'

" see (https://github.com/nathanaelkane/vim-indent-guides)
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" see (https://github.com/plasticboy/vim-markdown)
let g:tex_conceal = ""
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_no_default_key_mappings = 1

" --------------------------------------
" Edit
"
set autoread
set clipboard=unnamed
set hidden
set mouse=a
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

" --------------------------------------
" Indent
"
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" --------------------------------------
" Search & Replacement
"
set gdefault
set hlsearch
set ignorecase
set incsearch
set shortmess-=S
set smartcase
set wrapscan

" --------------------------------------
" Spell
"
set spelllang+=cjk
set spell

" --------------------------------------
" View
"
set ambiwidth=double
set cursorline
set list listchars=space:␣,tab:>-,trail:~,nbsp:%,extends:>,precedes:<
set number
set ruler
set showmatch
set showtabline=2
set title
set wildmenu wildmode=list:longest

" --------------------------------------
" Status Line
"
set laststatus=2
set statusline=[%{getcwd()}]
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=%=
set statusline+=[%{&fileencoding}]
set statusline+=%y
set statusline+=[ROW=%l/%L]
set statusline+=[COL=%c]

" --------------------------------------
" Highlight
"
augroup OverrideHighlight
  autocmd!
  autocmd Syntax * call AddSyntax()
  autocmd ColorScheme * call ForceHighlight()
augroup END

function! AddSyntax() abort
  call matchadd('Todo', 'TODO:\|FIXME:\|DEBUG:\|NOTE:\|WARNING:')
  call matchadd('Error', '　\|\s\+$\|\[ \]')
endfunction

function! ForceHighlight() abort
  highlight clear CursorLine
  highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE
  highlight clear SpecialKey
  highlight SpecialKey cterm=NONE ctermfg=DarkGray ctermbg=NONE
  if has('nvim')
    highlight clear Whitespace
    highlight Whitespace cterm=NONE ctermfg=DarkGray ctermbg=NONE
  endif
  highlight clear SpellBad
  highlight SpellBad cterm=NONE ctermfg=DarkRed ctermbg=NONE
  highlight Todo cterm=NONE ctermfg=Black ctermbg=DarkYellow
  highlight Error cterm=NONE ctermfg=Black ctermbg=DarkRed
endfunction

" --------------------------------------
" Color
"
set t_Co=256

" see (https://github.com/w0ng/vim-hybrid)
set background=dark
colorscheme hybrid

" default dark colorschemes
" colorscheme desert
" colorscheme elflord
" colorscheme industry
" colorscheme pablo

" default dark colorschemes I don't like
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

" default light colorschemes
" colorscheme evening
" colorscheme morning
" colorscheme shine

" --------------------------------------
" Function
"
" Avoiding the 'Hit ENTER to continue' prompts
command! -nargs=1 Silent
  \ execute 'silent !' . <q-args> |
  \ execute 'redraw!'

command! -nargs=0 FixWhitespace call FixWhitespace()
function! FixWhitespace() abort
  execute '%s/\s\+$//e'
endfunction

" 'path:line_number' must be yanked
command! -nargs=1 OpenWithVim call OpenWithVim()
function! OpenWithVim() abort
  " call feedkeys('yi(', 'nx')
  let l:path = @*
  let l:path = @*
  let l:file_path = matchstr(l:path, '.*\ze:')
  let l:line = matchstr(l:path, '.*:\zs.*')
  execute 'silent vi +' . l:line . ' ' . l:file_path
endfunction

" Save PlantUML as designated format
command! -nargs=1 PuSave call PuSave(<f-args>)
function! PuSave(format) abort
  let l:path = expand('%:p')
  let l:path_wo_ex = matchstr(l:path, '.*\ze\.')
  execute 'Silent java -jar ' . expand('~/plantuml.jar') . ' -charset UTF-8 -t' . a:format . ' ' . l:path
endfunction

command! -nargs=0 MyRebuild call MyRebuild()
function! MyRebuild() abort
  execute 'bo terminal ++noclose ./my_rebuild.bat'
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
augroup vimrc-local
  autocmd!
  autocmd TabEnter,BufWinEnter,BufNewFile,BufReadPost * lcd %:p:h
  autocmd TabEnter,BufWinEnter,BufNewFile,BufReadPost * silent! call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('local.vim', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
