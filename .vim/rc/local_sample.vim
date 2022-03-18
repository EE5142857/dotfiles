scriptencoding utf-8

if index(g:l_sourced_local_vimrc_path, fnamemodify(@%, ':p')) < 0
  " l:cwd = getcwd()
  " lcd <sfile>:p:h
  " Silent ctags -R .
  " execute 'lcd' l:cwd
  call AddPath([
  \ 'C:\work\myenv\Scripts'
  \ ])
endif

let g:python3_host_prog = 'C:\work\myenv\Scripts\python.exe'
let g:jupytext_command = 'C:\work\myenv\Scripts\jupytext.exe'

function! StartJupyter() abort
  execute 'wincmd l'
  call feedkeys("i")
  call feedkeys("C:\\work\\myenv\\Scripts\\activate.bat\<CR>")
  call feedkeys("ipython\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! StartPython() abort
  execute 'wincmd l'
  call feedkeys("i")
  call feedkeys("C:\\work\\myenv\\Scripts\\activate.bat\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! StartJupyter() abort
  execute 'wincmd l'
  call feedkeys("i")
  call feedkeys("activate\<CR>")
  call feedkeys("ipython\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! StartPython() abort
  execute 'wincmd l'
  call feedkeys("i")
  call feedkeys("activate\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! StartSQL() abort
  execute 'wincmd l'
  call feedkeys("i")
  call feedkeys("psql -U postgres -d recipe\<CR>")
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
