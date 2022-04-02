scriptencoding utf-8

" source ~/.vim/local_sample.vim

let s:path_wo_symbol = substitute(fnamemodify(expand('<sfile>:p'), ':p'), '[^a-zA-Z0-9]', '_', 'g')
if !exists('g:{s:path_wo_symbol}')
  let g:{s:path_wo_symbol} = 1
  " l:cwd = getcwd()
  " lcd <sfile>:p:h
  " !ctags -R .
  " execute 'lcd' l:cwd
endif

let g:my_plantuml_path = expand('$USERPROFILE\plantuml.jar')
let g:python3_host_prog = 'C:\work\myenv\Scripts\python.exe'
let g:jupytext_command = 'C:\work\myenv\Scripts\jupytext.exe'

call vimrc#add_path([
\ 'C:\work\myenv\Scripts'
\])

" vim: foldmethod=marker nofoldenable
