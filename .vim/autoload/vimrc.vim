scriptencoding utf-8

" --------------------------------------
" filetype
" {{{
function! vimrc#ft_common() abort
  if has('nvim')
    setlocal formatoptions+=n formatoptions-=ro
  endif
  setlocal foldmethod=indent nofoldenable
  setlocal autoindent smartindent
  setlocal expandtab
  setlocal shiftwidth=4 softtabstop=4 tabstop=4
endfunction
" }}}

" --------------------------------------
" syntax
" {{{
function! vimrc#syntax() abort
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
  highlight MyError     cterm=NONE ctermfg=Black ctermbg=Red
  highlight MyError     gui=NONE guifg=Black guibg=Red
  highlight MySpecial   cterm=NONE ctermfg=Red ctermbg=NONE
  highlight MySpecial   gui=NONE guifg=Red guibg=NONE
  highlight MyTodo      cterm=NONE ctermfg=Black ctermbg=Yellow
  highlight MyTodo      gui=NONE guifg=Black guibg=Yellow
  call matchadd('MyError', '　\|\[ \]')
  call matchadd('MySpecial', '\t\|\s\+$') " [		] 
  call matchadd('MyTodo', 'TODO:\|FIXME:\|DEBUG:\|NOTE:\|WARNING:')
endfunction
" }}}

" --------------------------------------
" mark
" {{{
function! vimrc#restore_cursor() abort
  if (line("'\"") >= 1) && (line("'\"") <= line("$"))
    execute "normal! g'\""
  endif
endfunction
" }}}

" --------------------------------------
" register
" {{{
function! vimrc#delete_register() abort
  let regs = split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
  if has('nvim')
    wshada!
  else
    wviminfo!
  endif
endfunction

function! vimrc#update_register() abort
  " using filename-modifiers
  if empty(&buftype)
    let @a = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
    let @b = substitute(fnamemodify(@%, ':p:h'), '\\', '\/', 'g')
    let @c = substitute(fnamemodify(@%, ':p'), '\/', '\\', 'g')
    let @d = substitute(fnamemodify(@%, ':p:h'), '\/', '\\', 'g')
    let @e = fnamemodify(@%, ':t')
  endif
endfunction
" }}}

" --------------------------------------
" local setting
" {{{
function! vimrc#source_local_vimrc(path) abort
  if !empty(&buftype)
    return
  endif

  " upward compatibility with 'set autochdir'
  execute 'lcd' fnamemodify(expand(a:path), ':p:h')

  let l:l_vimrc_path = []
  for l:i in reverse(findfile('local.vim', escape(a:path, ' ') . ';', -1))
    call add(l:l_vimrc_path, fnamemodify(l:i, ':p'))
  endfor

  for l:i in l:l_vimrc_path
    execute 'source' l:i
  endfor
endfunction

function! vimrc#add_path(l_path) abort
  " https://lambdalisue.hatenablog.com/entry/2015/12/25/000046
  " if has('win32') || has ('win64')
    let l:l_path = split($PATH, ";")
    for l:item in reverse(a:l_path)
      let l:index = index(l:l_path, l:item)
      if l:index < 0
        call insert(l:l_path, l:item)
      else
        call remove(l:l_path, l:index)
        call insert(l:l_path, l:item)
      endif
    endfor
    let $PATH = join(l:l_path, ";")
  " endif
endfunction
" }}}

" vim: foldmethod=marker nofoldenable
