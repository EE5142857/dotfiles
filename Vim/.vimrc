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
nnoremap Q <Nop>
nnoremap j gj
nnoremap k gk
nnoremap <Space>wr :set wrap!<CR>

" Encoding
nnoremap <Space>es :edit ++encoding=cp932<CR>
nnoremap <Space>eu :edit ++encoding=utf-8<CR>

" .vimrc
nnoremap <Space>ed :edit ~/.vim/dein/dein.toml<CR>
nnoremap <Space>eg :edit ~/.gvimrc<CR>
nnoremap <Space>ev :edit ~/.vimrc<CR>
nnoremap <Space>sv :source ~/.vimrc<CR>

" Copy directory
nnoremap <Space>cd :let @a = expand('%:h')<CR>

" Copy path
nnoremap <Space>cp :let @a = expand('%:p')<CR>

" Copy file name
nnoremap <Space>cf :let @a = expand('%:t')<CR>

" Function
nnoremap <Space>oe :call OpenWithExplorer()<CR>
nnoremap <Space>ov :call OpenWithVim()<CR>

" Plugin
nmap s <Plug>(easymotion-overwin-f2)
nnoremap <Space>nt :NERDTreeToggle<CR>
nnoremap <Space>ob :execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')<CR>
nnoremap <Space>tm :TableModeToggle<CR>

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
set ignorecase
set incsearch
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
set cursorline
set list listchars=tab:>-,trail:~,nbsp:%,extends:>,precedes:<
set number
set ruler
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
"colorscheme koehler
"colorscheme murphy
"colorscheme pablo
"colorscheme torte

" ------------------------------------------------------------------------------
" Highlight
"
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
highlight CursorLine gui=underline guifg=NONE guibg=NONE

augroup OverrideHighlight
  autocmd!
  autocmd Syntax * :silent! call matchadd('Todo', '\(TODO\|FIXME\|DEBUG\|NOTE\|WARNING\):')
  autocmd Syntax * :silent! highlight Todo
  autocmd Syntax * :silent! call matchadd('Error', '　\|\s\+$')
  autocmd Syntax * :silent! highlight Error
augroup END

" ------------------------------------------------------------------------------
" Function
"
function! HelloWorld() abort
  return 'Hello, World!'
endfunction

" Open file/folder with Explorer.
function! OpenWithExplorer() abort
  call feedkeys('vi]y', 'nx')
  let l:path = @0
  execute "r!explorer " . l:path
endfunction

" Open file and go to particular line number.
" available [local_file_path:line_number]
function! OpenWithVim() abort
  call feedkeys("vi]y", "nx")
  let l:file_path_with_line = @0
  let l:file_path = matchstr(l:file_path_with_line, '.*\ze:')
  let l:line = matchstr(l:file_path_with_line, '.*:\zs.*')
  execute "vi +" . l:line . " " . l:file_path
endfunction

command! -nargs=0 PuOpen call PuOpen()
function! PuOpen() abort
  let l:path = expand('%:p')
  let l:path_wo_ex = matchstr(l:path, '.*\ze\.')
  let l:svg_path = l:path_wo_ex . '.svg'
  execute "r!java -jar " . expand('~/plantuml.jar') . " -charset UTF-8 -tsvg " . l:path
  execute "OpenBrowser " . l:svg_path
endfunction

command! -nargs=0 PuUpdate call PuUpdate()
function! PuUpdate() abort
  let l:path = expand('%:p')
  execute "r!java -jar " . expand('~/plantuml.jar') . " -charset UTF-8 -tsvg " . l:path
endfunction

command! -nargs=1 PuSave call PuSave(<f-args>)
function! PuSave(extension) abort
  let l:path = expand('%:p')
  let l:path_wo_ex = matchstr(l:path, '.*\ze\.')
  let l:svg_path = l:path_wo_ex . '.svg'
  execute "r!del " . l:svg_path
  execute "r!java -jar " . expand('~/plantuml.jar') . " -charset UTF-8 -t" . a:extension . " " . l:path
endfunction

" ------------------------------------------------------------------------------
" Plugin
"
" see https://github.com/tyru/open-browser.vim
" see also http://hanagurotanuki.blogspot.com/2015/03/windowsopen-browservimchrome.html
if has('win32') || has('win64')
  let g:openbrowser_browser_commands = [
  \   {
  \     'name': 'chrome',
  \     'args': ['{browser}', '{uri}']
  \   }
  \ ]
endif

" see https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1

" see https://github.com/preservim/nerdtree
let g:NERDTreeShowBookmarks = 1

" see https://github.com/easymotion/vim-easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" see https://github.com/Yggdroot/indentLine
let g:indentLine_enabled = 1

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

augroup FileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.py
    \ setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd BufNewFile,BufRead .vimrc,.gvimrc,*.vim
    \ setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

" ******************************************************************************
" Project-specific settings
" ******************************************************************************

" ------------------------------------------------------------------------------
" Local Settings
"
"   Load settings for each location.
"   see https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
"
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('local.vim', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
