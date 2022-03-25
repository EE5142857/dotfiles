if &compatible
  set nocompatible " Be iMproved
endif

set encoding=utf-8
scriptencoding utf-8

language messages C

filetype off
filetype plugin indent off
syntax off

" --------------------------------------
" variable
" {{{
let g:loaded_netrwPlugin = 1
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
" source
" {{{
if filereadable(expand('~/.vim/rc/option.vim'))
  source ~/.vim/rc/option.vim
endif

if filereadable(expand('~/.vim/rc/autocmd.vim'))
  source ~/.vim/rc/autocmd.vim
endif

if filereadable(expand('~/.vim/rc/command.vim'))
  source ~/.vim/rc/command.vim
endif

if filereadable(expand('~/.vim/rc/keymap.vim'))
  source ~/.vim/rc/keymap.vim
endif

if filereadable(expand('~/.vim/rc/dein.vim')) && has('nvim')
  source ~/.vim/rc/dein.vim
else
  if &diff
    syntax off
    set nospell
  else
    filetype plugin indent on
    syntax enable
  endif

  " colorscheme (if needed)
  colorscheme desert
  " colorscheme evening
endif
" }}}

" --------------------------------------
" highlight
" {{{
highlight CursorLine  cterm=NONE ctermfg=NONE ctermbg=NONE
highlight CursorLine  gui=NONE guifg=NONE guibg=NONE
highlight Folded      cterm=NONE ctermfg=DarkGray ctermbg=NONE
highlight Folded      gui=NONE guifg=DarkGray guibg=NONE
highlight SpecialKey  cterm=NONE ctermfg=DarkGray ctermbg=NONE
highlight SpecialKey  gui=NONE guifg=DarkGray guibg=NONE
if has('nvim')
  highlight Whitespace  cterm=NONE ctermfg=DarkGray ctermbg=NONE
  highlight Whitespace  gui=NONE guifg=DarkGray guibg=NONE
endif

highlight DiffAdd     cterm=NONE ctermfg=NONE ctermbg=Green
highlight DiffAdd     gui=NONE guifg=NONE guibg=Green
highlight DiffChange  cterm=NONE ctermfg=NONE ctermbg=NONE
highlight DiffChange  gui=NONE guifg=NONE guibg=NONE
highlight DiffDelete  cterm=NONE ctermfg=LightBlue ctermbg=Red
highlight DiffDelete  gui=NONE guifg=LightBlue guibg=Red
highlight DiffText    cterm=NONE ctermfg=Yellow ctermbg=Red
highlight DiffText    gui=NONE guifg=Yellow guibg=Red
" }}}

" --------------------------------------
" .vim directory layout
" {{{
" ~/.vim/init.vim
" ~/.vim/local_sample.vim
" ~/.vim/autoload/vimrc.vim
" ~/.vim/rc/autocmd.vim
" ~/.vim/rc/command.vim
" ~/.vim/rc/dein_lazy.toml
" ~/.vim/rc/dein_lazy_ddc.toml
" ~/.vim/rc/dein_nolazy.toml
" ~/.vim/rc/keymap.vim
" ~/.vim/rc/option.vim
" ~/.vim/snippets/markdown.snip
" }}}
