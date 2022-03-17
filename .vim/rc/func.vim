scriptencoding utf-8
" --------------------------------------
" command
"
" :args **/*.*
" :argdo %s/old/new/g | update
" :argdo %s/old/new/gc | update
" :argdelete *
command! -nargs=1 Silent
\ execute 'silent !' . <q-args>
\|execute 'redraw!'

command! -nargs=1 P
\ execute 'let @* = @' . <q-args>

command! -nargs=1 F
\ execute 'vimgrep /' . <q-args> . '/g **/*.*'

command! -nargs=0 Trim
\ execute '%s/\s\+$//e'

command! -nargs=0 S
\ execute 'split | resize 5 | terminal'

command! -nargs=0 V
\ execute 'vsplit | terminal'
\|execute 'wincmd h'

" --------------------------------------
" terminal setup
"
command! -nargs=0 TS call TS()
function! TS() abort
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

function! StartJupyter() abort
  " execute 'wincmd l'
  " call feedkeys("i")
  " call feedkeys("activate\<CR>")
  " call feedkeys("ipython\<CR>")
  " call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! StartPython() abort
endfunction

function! StartSQL() abort
endfunction

" --------------------------------------
" terminal execution
"
command! -nargs=0 TE call TE()
function! TE() abort
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

function! ExecutePython() abort
  let l:filepath = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  execute 'wincmd l'
  call feedkeys("i" . l:filepath . "\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! ExecuteSQL() abort
  let l:filepath = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  execute 'wincmd l'
  call feedkeys("i" . "\\i " . l:filepath . "\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! ExecuteR() abort
  let l:filepath = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  execute 'wincmd l'
  call feedkeys("i" . "rscript --encoding=utf-8 " . l:filepath . "\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

" --------------------------------------
" local setting
"
" https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
"
" ```vimscript:local.vim
" if index(g:l_sourced_vimrc_path, fnamemodify(@%, ':p')) < 0
"   lcd <sfile>:p:h
"   Silent ctags -R .
" endif
"
" let g:python3_host_prog = 'C:\Users\daiki\scoop\apps\python39\current\python3.exe'
" let g:jupytext_command = 'C:\work\myenv\Scripts\jupytext.exe'
" ```
"
augroup MyLocalVimrc
  autocmd!
  autocmd BufNewFile,BufReadPost,BufEnter * call SourceLocalVimrc(fnamemodify(@%, ':p'))
augroup END

function! SourceLocalVimrc(path) abort
  if (&buftype == 'terminal') || (&buftype == 'quickfix')
    return
  endif

  if !exists('g:l_sourced_vimrc_path')
    let g:l_sourced_vimrc_path = []
  endif

  let l:l_vimrc_path = []
  for l:i in reverse(findfile('local.vim', escape(a:path, ' ') . ';', -1))
    call add(l:l_vimrc_path, fnamemodify(l:i, ':p'))
  endfor

  let g:l_sourced_vimrc_path = uniq(sort(g:l_sourced_vimrc_path + l:l_vimrc_path))

  for l:i in l:l_vimrc_path
    execute 'source' l:i
  endfor
endfunction
