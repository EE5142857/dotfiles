scriptencoding utf-8

let s:path = substitute(fnamemodify(expand('<sfile>:p'), ':p'), '\\', '\/', 'g')
if index(g:l_sourced_local_vimrc_path, s:path) < 0
  " l:cwd = getcwd()
  " lcd <sfile>:p:h
  " Silent ctags -R .
  " execute 'lcd' l:cwd
endif

call AddPath([
\ 'C:\work\myenv\Scripts'
\])

let g:python3_host_prog = 'C:\work\myenv\Scripts\python.exe'
let g:jupytext_command = 'C:\work\myenv\Scripts\jupytext.exe'

function! StartJupyter() abort
  wincmd l
  startinsert
  call feedkeys("activate.bat\<CR>")
  call feedkeys("ipython\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("\<C-w>h")
endfunction

function! StartPython() abort
  wincmd l
  startinsert
  call feedkeys("activate.bat\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("\<C-w>h")
endfunction

function! StartSQL() abort
  wincmd l
  startinsert
  call feedkeys("psql -U postgres -d recipe\<CR>")
endfunction

function! ExecuteJupyter() abort
  call feedkeys("\<C-c>\<C-c>")
endfunction

function! ExecutePython() abort
  let l:filepath = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  wincmd l
  startinsert
  call feedkeys(l:filepath . "\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("\<C-w>h")
endfunction

function! ExecuteSQL() abort
  let l:filepath = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  wincmd l
  startinsert
  call feedkeys("\\i " . l:filepath . "\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("\<C-w>h")
endfunction

function! ExecuteR() abort
  let l:filepath = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  wincmd l
  startinsert
  call feedkeys("rscript --encoding=utf-8 " . l:filepath . "\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("\<C-w>h")
endfunction
