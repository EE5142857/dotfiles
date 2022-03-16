" --------------------------------------
" dein.vim
"
" https://github.com/Shougo/dein.vim
" https://knowledge.sakura.ad.jp/23248/
"
if has('nvim')
  let s:dein_dir = expand('~/.cache/nvim/dein')
else
  let s:dein_dir = expand('~/.cache/vim/dein')
endif
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
  let s:toml_vim = s:rc_dir . '/dein_vim.toml'
  let s:toml_vim_lazy = s:rc_dir . '/dein_vim_lazy.toml'
  let s:toml_nvim = s:rc_dir . '/dein_nvim.toml'
  let s:toml_nvim_lazy = s:rc_dir . '/dein_nvim_lazy.toml'

  " read toml and cache
  call dein#load_toml(s:toml_vim, {'lazy': 0})
  call dein#load_toml(s:toml_vim_lazy, {'lazy': 1})
  if has('nvim')
    call dein#load_toml(s:toml_nvim, {'lazy': 0})
    call dein#load_toml(s:toml_nvim_lazy, {'lazy': 1})
  endif

  " end settings
  call dein#end()
  call dein#save_state()
endif

if ($HOME != $USERPROFILE) && ($GIT_EXEC_PATH != '')
  " gitcommit
  finish
endif

if dein#check_install()
  call dein#install()
endif

let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif

call dein#call_hook('source')
