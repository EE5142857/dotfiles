" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" ------------------------------------------------------------------------------
" dein.vim
"
source ~/.vim/dein/dein.vim

" Required
filetype plugin indent on
syntax enable

" ------------------------------------------------------------------------------
" Keymap
"
let mapleader = ","

nnoremap Q <Nop>
nnoremap q <Nop>

nnoremap j gj
nnoremap k gk

" Toggle wrap
nnoremap <silent> <Space>tw :set wrap!<CR>

" Increase/decrease indent in a row
vnoremap < <gv
vnoremap > >gv

" Move lines
nnoremap <C-Down> "zdd"zp
nnoremap <C-Up> "zdd<Up>"zP
vnoremap <C-Down> "zx"zp`[V`]
vnoremap <C-Up> "zx<Up>"zP`[V`]

" Encoding
nnoremap <silent> <Space>es :edit ++encoding=cp932<CR>
nnoremap <silent> <Space>eu :edit ++encoding=utf-8<CR>

" .vimrc
nnoremap <silent> <Space>ed :edit ~/.vim/dein/dein.toml<CR>
nnoremap <silent> <Space>ev :edit ~/.vimrc<CR>
nnoremap <silent> <Space>sv :source ~/.vimrc<CR>

" Copy directory, file name and path
nnoremap <silent> <Space>cd :let @* = expand('%:p:h')<CR>
nnoremap <silent> <Space>cf :let @* = expand('%:t')<CR>
nnoremap <silent> <Space>cp :let @* = expand('%:p')<CR>

" Function
nnoremap <silent> <Space>oc :call OpenWithChrome()<CR>
nnoremap <silent> <Space>of :call OpenWithFiler()<CR>
nnoremap <silent> <Space>ov :call OpenWithVim()<CR>

" see (https://github.com/Shougo/neosnippet.vim)
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" see (https://github.com/easymotion/vim-easymotion)
nmap s <Plug>(easymotion-overwin-f2)

" see (https://github.com/plasticboy/vim-markdown)
nnoremap <silent> <Space>tf :TableFormat<CR>

" ------------------------------------------------------------------------------
" Plugin
"
" see (https://github.com/Shougo/neosnippet.vim)
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" see (https://github.com/Yggdroot/indentLine)
let g:indentLine_enabled = 1

" see (https://github.com/easymotion/vim-easymotion)
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" see (https://github.com/plasticboy/vim-markdown)
let g:tex_conceal = ""
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_no_default_key_mappings = 1

" see (https://github.com/goerz/jupytext.vim)
" let g:jupytext_enable = 1
" let g:jupytext_fmt = 'md'
" let g:jupytext_fmt = 'py:percent'
" let g:jupytext_filetype_map = {'py': 'python'}

" ------------------------------------------------------------------------------
" Function
"
" Avoiding the 'Hit ENTER to continue' prompts
command! -nargs=1 Silent
  \ execute 'silent !' . <q-args> |
  \ execute 'redraw!'

function! OpenWithChrome() abort
  "call feedkeys('yi(', 'nx')
  let l:path = @*
  execute 'Silent chrome ' . l:path
endfunction

function! OpenWithFiler() abort
  "call feedkeys('yi[', 'nx')
  let l:path = @*
  execute 'Silent start ' . '"' . l:path . '"'
endfunction

" 'path:line_number' must be yanked
function! OpenWithVim() abort
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

" ------------------------------------------------------------------------------
" Edit
"
set autoread
set clipboard=unnamed
set hidden
set nobackup
set noswapfile
set noundofile
set nowritebackup

" ------------------------------------------------------------------------------
" Search & Replacement
"
set gdefault
set hlsearch
set ignorecase
set incsearch
set shortmess-=S
set smartcase
set wrapscan

" ------------------------------------------------------------------------------
" Spell
"
set spelllang+=cjk
set spell

" ------------------------------------------------------------------------------
" View
"
set ambiwidth=double
set cursorline
set list listchars=tab:>-,trail:~,nbsp:%,extends:>,precedes:<
set number
set ruler
set laststatus=2
set showmatch
set wildmenu wildmode=list:longest

augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

" ------------------------------------------------------------------------------
" Color
"
colorscheme industry
" colorscheme koehler
" colorscheme murphy
" colorscheme pablo
" colorscheme torte

" highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" highlight SpellBad cterm=underline ctermfg=red ctermbg=NONE

" see (https://itchyny.hatenablog.com/entry/20130828/1377653592)
set t_Co=256

augroup OverrideHighlight
  autocmd!
  autocmd TabEnter,WinEnter,VimEnter,ColorScheme,Syntax * call MyHighlight()
augroup END

function! MyHighlight() abort
  silent! call matchadd('Todo', '\(TODO\|FIXME\|DEBUG\|NOTE\|WARNING\):')
  silent! highlight Todo
  silent! call matchadd('Error', '　\|\s\+$\|\[ \]')
  silent! highlight Error
  silent! highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
  silent! highlight SpellBad cterm=underline ctermfg=red ctermbg=NONE
endfunction

" ******************************************************************************
" File-type-specific settings
" ******************************************************************************

" ------------------------------------------------------------------------------
" Encoding
"
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp

" ------------------------------------------------------------------------------
" Indent
"
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" ******************************************************************************
" Project-specific settings
" ******************************************************************************

" ------------------------------------------------------------------------------
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
  autocmd TabEnter,BufNewFile,BufReadPost * silent! call s:vimrc_local(expand('<afile>:p:h'))
  autocmd TabEnter * pwd
augroup END

function! s:vimrc_local(loc)
  let files = findfile('local.vim', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
