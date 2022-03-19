scriptencoding utf-8

let s:path_wo_symbol = substitute(fnamemodify(expand('<sfile>:p'), ':p'), '[^a-zA-Z0-9]', '_', 'g')
if !exists('g:{s:path_wo_symbol}')
  let g:{s:path_wo_symbol} = 1
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
  " call feedkeys("activate.bat\<CR>")
  call feedkeys("ipython\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("G\<C-w>h")
endfunction

function! StartPython() abort
  " wincmd l
  " startinsert
  " call feedkeys("activate.bat\<CR>")
  " call feedkeys("\<C-\>\<C-n>")
  " call feedkeys("G\<C-w>h")
endfunction

function! StartSQL() abort
  wincmd l
  startinsert
  call feedkeys("pg_ctl start\<CR>")
  call feedkeys("psql -U postgres -d recipe\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("G\<C-w>h")
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
