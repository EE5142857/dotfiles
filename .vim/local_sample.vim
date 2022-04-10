scriptencoding utf-8

" source ~/.vim/local_sample.vim

if vimrc#is_first_load() == v:true
  " l:cwd = getcwd()
  " lcd <sfile>:p:h
  " !ctags -R .
  " execute 'lcd' l:cwd
endif

let g:my_plantuml_path = expand('$USERPROFILE\scoop\apps\plantuml\current\plantuml.jar')
let g:python3_host_prog = 'C:\work\myenv\Scripts\python.exe'
let g:jupytext_command = 'C:\work\myenv\Scripts\jupytext.exe'

call vimrc#add_path([
\ 'C:\work\myenv\Scripts'
\])

" vim: foldmethod=marker nofoldenable
