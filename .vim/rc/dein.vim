scriptencoding utf-8

" --------------------------------------
" dein.vim
"
" https://github.com/Shougo/dein.vim
" https://knowledge.sakura.ad.jp/23248/
"
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir.'/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath+=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.vim/rc')
  let s:toml_vim = s:rc_dir . '/dein.toml'
  let s:toml_vim_lazy = s:rc_dir . '/dein_lazy.toml'

  " read toml and cache
  call dein#load_toml(s:toml_vim, {'lazy': 0})
  call dein#load_toml(s:toml_vim_lazy, {'lazy': 1})

  " end settings
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif

" call dein#call_hook('source')
