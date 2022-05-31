scriptencoding utf-8

if has('unix')
  let g:my_plantuml_path = ''
  let g:python3_host_prog = '~/work/venv/myenv/bin/python3.10'
  let g:jupytext_command = '~/work/venv/myenv/bin/jupytext'

  call vimrc#add_path([
  \ '~/work/venv/myenv/bin'
  \])
endif

" vim: foldmethod=marker nofoldenable
