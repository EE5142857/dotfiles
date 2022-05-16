scriptencoding utf-8

if has('win32') || has('win64')
  let g:my_plantuml_path = ''
  let g:python3_host_prog = 'C:\work\myenv\Scripts\python.exe'
  let g:jupytext_command = 'C:\work\myenv\Scripts\jupytext.exe'

  call vimrc#add_path([
  \ 'C:\work\myenv\Scripts'
  \])
endif

" vim: foldmethod=marker nofoldenable
