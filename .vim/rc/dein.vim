scriptencoding utf-8

" https://github.com/Shougo/dein.vim
" https://knowledge.sakura.ad.jp/23248/
" https://github.com/Shougo/shougo-s-github/blob/master/vim/rc/vimrc
let g:dein#lazy_rplugins = v:true
let g:dein#install_progress_type = 'floating'

if &runtimepath !~# '/dein.vim'
  if has('nvim')
    let s:dein_dir = expand('~/.cache/nvim/dein')
  else
    let s:dein_dir = expand('~/.cache/vim/dein')
  endif
  let s:dein_repo_dir = s:dein_dir.'/repos/github.com/Shougo/dein.vim'

  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath+=' . s:dein_repo_dir
endif

if dein#min#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:base_dir = expand('~/.vim/rc') . '/'
  let s:toml_nolazy   = s:base_dir . 'dein_nolazy.toml'
  let s:toml_lazy     = s:base_dir . 'dein_lazy.toml'
  let s:toml_lazy_ddc = s:base_dir . 'dein_lazy_ddc.toml'

  call dein#load_toml(s:toml_nolazy,    {'lazy': 0})
  call dein#load_toml(s:toml_lazy,      {'lazy': 1})
  call dein#load_toml(s:toml_lazy_ddc,  {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" Required
filetype plugin indent on
syntax enable

" set colorscheme
call dein#call_hook('source')
