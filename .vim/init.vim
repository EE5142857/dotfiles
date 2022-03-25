if &compatible
  set nocompatible " Be iMproved
endif

set encoding=utf-8
scriptencoding utf-8

language messages C

" --------------------------------------
" variable
" {{{
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_dirhistmax = 1
let g:netrw_home = '~/.vim'
let g:netrw_liststyle = 3
let g:netrw_sizestyle = 'H'
let g:netrw_special_syntax = 1
let g:netrw_timefmt = '%Y-%m-%d %H:%M:%S'
let g:netrw_winsize = 85
let g:vim_indent_cont = 0
" }}}

" --------------------------------------
" command
" {{{
" NOTE: vimgrep
  " :vimgrep /word/g **/*.*
" NOTE: argdo
  " :args **/*.*
  " :argdo %s/old/new/g | update
  " :argdo %s/old/new/gc | update
  " :argdelete *
" NOTE: cdo
  " :cdo %s/old/new/g | update
  " :cdo %s/old/new/gc | update
command! -nargs=1 P execute 'let @* = @' . <q-args>
command! -nargs=1 G execute 'grep -ri ' . <q-args> . ' .'
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'
" }}}

" --------------------------------------
" dein.vim
" {{{
" set runtimepath
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

" dein options
let g:dein#auto_recache = v:true " NOTE: It is slow especially Windows.
let g:dein#install_progress_type = 'floating'
let g:dein#lazy_rplugins = v:true
let s:rc_dir = substitute(expand('~/.vim/rc'), '\\', '\/', 'g') . '/'
let g:dein#inline_vimrcs = ['option.vim', 'keymap.vim', 'autocmd.vim']
call map(g:deintest_inline_vimrcs, 's:rc_dir . v:val')

if dein#min#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:rc_dir . 'dein_nolazy.toml',    {'lazy': 0})
  call dein#load_toml(s:rc_dir . 'dein_lazy.toml',      {'lazy': 1})
  call dein#load_toml(s:rc_dir . 'dein_lazy_ddc.toml',  {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

call dein#update()

if dein#check_install()
  call dein#install()
endif

" Required
filetype plugin indent on
syntax enable

call dein#call_hook('source')
" }}}

" colorscheme (if needed)
" {{{
" colorscheme desert
" colorscheme evening
" }}}

" --------------------------------------
" highlight
" {{{
highlight CursorLine  cterm=underline ctermfg=NONE ctermbg=NONE
highlight CursorLine  gui=underline guifg=NONE guibg=NONE
highlight Folded      cterm=NONE ctermfg=DarkGray ctermbg=NONE
highlight Folded      gui=NONE guifg=DarkGray guibg=NONE
highlight SpecialKey  cterm=NONE ctermfg=DarkGray ctermbg=NONE
highlight SpecialKey  gui=NONE guifg=DarkGray guibg=NONE
if has('nvim')
  highlight Whitespace  cterm=NONE ctermfg=DarkGray ctermbg=NONE
  highlight Whitespace  gui=NONE guifg=DarkGray guibg=NONE
endif

highlight MyError     cterm=NONE ctermfg=Black ctermbg=Red
highlight MyError     gui=NONE guifg=Black guibg=Red
highlight MyTodo      cterm=NONE ctermfg=Black ctermbg=Yellow
highlight MyTodo      gui=NONE guifg=Black guibg=Yellow
highlight MySpecial   cterm=NONE ctermfg=Red ctermbg=NONE
highlight MySpecial   gui=NONE guifg=Red guibg=NONE
" }}}

" --------------------------------------
" .vim directory layout
" {{{
" ~/.vim/init.vim
" ~/.vim/autoload/vimrc.vim
" ~/.vim/rc/autocmd.vim
" ~/.vim/rc/dein.vim
" ~/.vim/rc/dein_lazy.toml
" ~/.vim/rc/dein_lazy_ddc.toml
" ~/.vim/rc/dein_nolazy.toml
" ~/.vim/rc/keymap.vim
" ~/.vim/rc/local_sample.vim
" ~/.vim/rc/option.vim
" ~/.vim/snippets/markdown.snip
" }}}
