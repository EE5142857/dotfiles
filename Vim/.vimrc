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
inoremap ( ()<LEFT>
inoremap < <><LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
nnoremap <silent> <Space>wr :set wrap!<CR>
nnoremap Q <Nop>
nnoremap j gj
nnoremap k gk

" Encoding
nnoremap <silent> <Space>es :edit ++encoding=cp932<CR>
nnoremap <silent> <Space>eu :edit ++encoding=utf-8<CR>

" .vimrc
nnoremap <silent> <Space>ed :edit ~/.vim/dein/dein.toml<CR>
nnoremap <silent> <Space>eg :edit ~/.gvimrc<CR>
nnoremap <silent> <Space>ev :edit ~/.vimrc<CR>
nnoremap <silent> <Space>sv :source ~/.vimrc<CR>

" Copy directory, path, file name
nnoremap <silent> <Space>cd :let @* = expand('%:h')<CR>
nnoremap <silent> <Space>cp :let @* = expand('%:p')<CR>
nnoremap <silent> <Space>cf :let @* = expand('%:t')<CR>

" Function
nnoremap <silent> <Space>oe :call OpenWithExplorer()<CR>
nnoremap <silent> <Space>ov :call OpenWithVim()<CR>
nnoremap <silent> f[ :call ChangeFontSize(-1)<CR>
nnoremap <silent> f] :call ChangeFontSize(1)<CR>

" ------------------------------------------------------------------------------
" Plugin
"
" see https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" see https://github.com/preservim/nerdtree
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
nnoremap <Space>nt :NERDTreeToggle<CR>

" see https://github.com/dhruvasagar/vim-table-mode
nnoremap <Space>tm :TableModeToggle<CR>

" see https://github.com/easymotion/vim-easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)

" see https://github.com/Yggdroot/indentLine
let g:indentLine_enabled = 1

" see https://github.com/goerz/jupytext.vim
let g:jupytext_enable = 1
let g:jupytext_fmt = 'py:percent'
let g:jupytext_filetype_map = {'py': 'python'}

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
set gdefault
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
"colorscheme koehler
"colorscheme murphy
"colorscheme pablo
"colorscheme torte

" ------------------------------------------------------------------------------
" Highlight
"
highlight CursorLine cterm=bold ctermfg=NONE ctermbg=NONE
highlight CursorLine gui=underline guifg=NONE guibg=NONE

augroup OverrideHighlight
  autocmd!
  autocmd Syntax * :silent! call matchadd('Todo', '\(TODO\|FIXME\|DEBUG\|NOTE\|WARNING\):')
  autocmd Syntax * :silent! highlight Todo
  autocmd Syntax * :silent! call matchadd('Error', '　\|\s\+$\|\[ \]')
  autocmd Syntax * :silent! highlight Error
augroup END

" ------------------------------------------------------------------------------
" Function
"
" Avoiding the "Hit ENTER to continue" prompts
command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

" Open a file/directory with explorer
" when the cursor is on [path].
function! OpenWithExplorer() abort
  call feedkeys('vi]y', 'nx')
  let l:path = @0
  execute "Silent explorer " . l:path
endfunction

" Open a file with Vim and go to specific line number
" when the cursor is on [path:line_number].
function! OpenWithVim() abort
  call feedkeys("vi]y", "nx")
  let l:file_path_with_line = @0
  let l:file_path = matchstr(l:file_path_with_line, '.*\ze:')
  let l:line = matchstr(l:file_path_with_line, '.*:\zs.*')
  execute "silent vi +" . l:line . " " . l:file_path
endfunction

" Change GVim font size
function! ChangeFontSize(diff) abort
  let l:gui_font = &guifont
  let l:gui_font1 = matchstr(l:gui_font, '.*:h\ze')
  let l:gui_font_size = matchstr(l:gui_font, '.*:h\zs.*\ze:.*')
  let l:gui_font_size_new = l:gui_font_size + a:diff
  let l:gui_font2 = matchstr(l:gui_font, '.*\zs:.*')
  execute "silent set guifont=" . l:gui_font1 . l:gui_font_size_new . l:gui_font2
endfunction

" Save PlantUML as designated format
command! -nargs=1 PuSave call PuSave(<f-args>)
function! PuSave(format) abort
  let l:path = expand('%:p')
  let l:path_wo_ex = matchstr(l:path, '.*\ze\.')
  execute "Silent java -jar " . expand('~/plantuml.jar') . " -charset UTF-8 -t" . a:format . " " . l:path
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


" ftdetect
augroup FileTypeSpecific
  autocmd!
  "autocmd FileType markdown
  "  \ highlight link markdownError NONE
  "autocmd FileType markdown
  "  \ highlight! def link markdownItalic Normal
  autocmd BufNewFile,BufRead *.pu,*.puml
    \ setf plantuml
  autocmd BufNewFile,BufRead *.py
    \ setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd BufNewFile,BufRead *.vim,.vimrc,.gvimrc
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
"   local.vim
"     lcd <sfile>:h
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
