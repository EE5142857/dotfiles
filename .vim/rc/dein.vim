scriptencoding utf-8

" --------------------------------------
" dein.vim
" {{{
let s:dein_dir = expand('~/.cache/dein/')
let s:dein_dir .= has('unix') ? 'unix_' : ''
let s:dein_dir .= has('nvim') ? 'nvim' : 'vim'
if &runtimepath !~# '/dein.vim'
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath+=' . s:dein_repo_dir
endif

" let g:dein#auto_recache = v:true
" let g:dein#inline_vimrcs = split(glob("~/.vim/rc/*.vim"), "\n")
let g:dein#install_check_diff = v:true
let g:dein#install_message_type = 'echo'
let g:dein#install_progress_type = 'echo'
let g:dein#lazy_rplugins = v:true
let g:dein#types#git#clone_depth = 1

if dein#min#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let s:rc_dir = expand('~/.vim/rc') . '/'
  call dein#load_toml(s:rc_dir . 'dein_vim_nolazy.toml',  {'lazy': 0})
  call dein#load_toml(s:rc_dir . 'dein_vim_lazy.toml',    {'lazy': 1})
  if has('nvim')
    call dein#load_toml(s:rc_dir . 'dein_nvim_nolazy.toml', {'lazy': 0})
    call dein#load_toml(s:rc_dir . 'dein_nvim_lazy.toml',   {'lazy': 1})
    call dein#load_toml(s:rc_dir . 'dein_nvim_ddc.toml',    {'lazy': 1})
    call dein#load_toml(s:rc_dir . 'dein_nvim_ddu.toml',    {'lazy': 1})
  endif
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
" }}}

" vim: foldmethod=marker nofoldenable
