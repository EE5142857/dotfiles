if &runtimepath !~# '/dein.vim'
  if has('nvim')
    let s:dein_dir = expand('~/.cache/nvim/dein')
  else
    if has('unix')
      let s:dein_dir = expand('~/.cache/unix_vim/dein')
    else
      let s:dein_dir = expand('~/.cache/vim/dein')
    endif
  endif
  let s:dein_repo_dir = s:dein_dir.'/repos/github.com/Shougo/dein.vim'

  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath+=' . s:dein_repo_dir
endif

let g:dein#install_check_diff = v:true
let g:dein#install_progress_type = 'floating'
let g:dein#lazy_rplugins = v:true
" let g:dein#inline_vimrcs = split(glob("~/.vim/rc/*.vim"), "\n")

if dein#min#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:rc_dir = substitute(expand('~/.vim/rc'), '\\', '\/', 'g') . '/'
  call dein#load_toml(s:rc_dir . 'dein_nolazy.toml',      {'lazy': 0})
  call dein#load_toml(s:rc_dir . 'dein_lazy.toml',        {'lazy': 1})
  call dein#load_toml(s:rc_dir . 'dein_lazy_ddc.toml',    {'lazy': 1})
  call dein#load_toml(s:rc_dir . 'dein_lazy_ddu.toml',    {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" call dein#update()

if dein#check_install()
  call dein#install()
endif

" Required
filetype plugin indent on
syntax enable

colorscheme desert
" colorscheme evening
call dein#call_hook('source')

" vim: foldmethod=marker nofoldenable
