scriptencoding utf-8

" --------------------------------------
" filetype
" {{{
function! vimrc#ft_common() abort
  if has('nvim')
    setlocal formatoptions+=n formatoptions-=ro
  endif
  setlocal foldmethod=indent nofoldenable
  setlocal autoindent
  " setlocal smartindent
  setlocal expandtab
  setlocal shiftwidth=4 softtabstop=4 tabstop=4
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
    let @a = substitute(fnamemodify(@%, ':p'),    '\\', '\/', 'g')
    let @b = substitute(fnamemodify(@%, ':p:h'),  '\\', '\/', 'g')
    let @c = substitute(fnamemodify(@%, ':p'),    '\/', '\\', 'g')
    let @d = substitute(fnamemodify(@%, ':p:h'),  '\/', '\\', 'g')
    let @e = fnamemodify(@%, ':t')
    let @f = fnamemodify(@%, ':p:h:t')
  endif
endfunction
" }}}

" --------------------------------------
" terminal
"   NOTE: for Vim
" {{{
function! vimrc#split(size) abort
  if a:size > 0
    execute a:size 'split'
  else
    split
  endif
  terminal ++curwin
  wincmd p
endfunction

function! vimrc#vsplit() abort
  vsplit
  terminal ++curwin
  wincmd p
endfunction

function! vimrc#send_cmd(cmd) abort
  wincmd p
  call feedkeys(a:cmd . "\<CR>")
  call feedkeys("\<C-g>p")
endfunction

function! vimrc#send_cell() abort
  let l:cell_delimiter = '# %%'
  let l:line_ini = search(l:cell_delimiter, 'bcnW')
  let l:line_end = search(l:cell_delimiter, 'nW')

  let l:line_ini = l:line_ini ? l:line_ini + 1 : 1
  let l:line_end = l:line_end ? l:line_end - 1 : line("$")

  execute line_ini . ',' . line_end . 'y'

  wincmd p
  call feedkeys("%paste", 'x')
  sleep 100m
  call feedkeys("\<CR>\<C-g>p", 'x')
endfunction
" }}}

" --------------------------------------
" highlight
" https://www.colordic.org/
" {{{
function! vimrc#highlight() abort
  " statusline
  if has('nvim')
    highlight StatusLine        cterm=NONE ctermfg=DarkGray ctermbg=Black
    highlight StatusLine        gui=NONE guifg=DarkGray guibg=Black
    highlight StatusLineNC      cterm=NONE ctermfg=Gray ctermbg=Black
    highlight StatusLineNC      gui=NONE guifg=Gray guibg=Black
  else
    highlight StatusLine        cterm=NONE ctermfg=Gray ctermbg=Black
    highlight StatusLine        gui=NONE guifg=Gray guibg=Black
    highlight StatusLineNC      cterm=NONE ctermfg=DarkGray ctermbg=Black
    highlight StatusLineNC      gui=NONE guifg=DarkGray guibg=Black
    highlight StatusLineTerm    cterm=NONE ctermfg=Gray ctermbg=Black
    highlight StatusLineTerm    gui=NONE guifg=Gray guibg=Black
    highlight StatusLineTermNC  cterm=NONE ctermfg=DarkGray ctermbg=Black
    highlight StatusLineTermNC  gui=NONE guifg=DarkGray guibg=Black
  endif

  " tabline
  highlight TabLine           cterm=NONE ctermfg=DarkGray ctermbg=Black
  highlight TabLine           gui=NONE guifg=DarkGray guibg=Black
  highlight TabLineFill       cterm=NONE ctermfg=DarkGray ctermbg=Black
  highlight TabLineFill       gui=NONE guifg=DarkGray guibg=Black
  highlight TabLineSel        cterm=NONE ctermfg=Black ctermbg=Gray
  highlight TabLineSel        gui=NONE guifg=Black guibg=Gray
endfunction
" }}}

" --------------------------------------
" syntax
" {{{
function! vimrc#syntax() abort
  highlight SpellBad    cterm=underline ctermfg=NONE ctermbg=NONE
  highlight SpellBad    gui=underline guifg=NONE guibg=NONE
  if has('unix') && !has('nvim')
    highlight SpellBad    term=underline guisp=NONE
  endif
  highlight MyError     cterm=NONE ctermfg=Black ctermbg=Red
  highlight MyError     gui=NONE guifg=Black guibg=Red
  highlight MySpecial   cterm=NONE ctermfg=Red ctermbg=NONE
  highlight MySpecial   gui=NONE guifg=Red guibg=NONE
  highlight MyEmphasis  cterm=NONE ctermfg=Black ctermbg=DarkYellow
  highlight MyEmphasis  gui=NONE guifg=Black guibg=DarkYellow
  call matchadd('MyError', '　\|\[ \]')
  call matchadd('MySpecial', '\t\|\s\+$') " [		] 
  call matchadd('MyEmphasis', 'TODO:\|FIXME:\|DEBUG:\|NOTE:\|WARNING:\|# %%')
endfunction
" }}}

" --------------------------------------
" tabline
" https://qiita.com/wadako111/items/755e753677dd72d8036d
" {{{
function! vimrc#tabline() abort
  let l:ret = ''
  for l:i in range(1, tabpagenr('$'))
    let l:bufnrs = tabpagebuflist(l:i)
    let l:bufnr = l:bufnrs[tabpagewinnr(l:i) - 1]
    let l:no = l:i
    let l:mod = getbufvar(l:bufnr, '&modified') ? ' + ' : ' '
    let l:title = fnamemodify(bufname(l:bufnr), ':t')
    if empty(l:title)
      let l:title = '[No Name]'
    endif
    if strlen(l:title) > 20
      let l:title = l:title[0:19]
    endif
    let l:ret .= '%' . l:i . 'T'
    let l:ret .= '%#' . (l:i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let l:ret .= ((l:i > 1 ) && (l:i < tabpagenr())) ? '|' : ''
    let l:ret .= ' ' . l:no . ' ' . l:title
    let l:ret .= l:mod
    let l:ret .= ((l:i > tabpagenr()) && (l:i < tabpagenr('$'))) ? '|' : ''
    let l:ret .= '%#TabLineFill#'
  endfor

  let l:ret .= '%#TabLineFill#%T%=%#TabLineFill#'
  let l:ret .= ' '
  let l:ret .= fnamemodify(getcwd(), ':t') . '/'
  let l:ret .= ' '

  if has('win32') || has('win64')
    let l:lf = "\r\n"
  elseif has('unix')
    let l:lf = "\n"
  else
    let l:lf = "\r"
  endif
  if system('git rev-parse --is-inside-work-tree') =~ 'true'
    let l:my_git_repo_name = fnamemodify(substitute(system('git rev-parse --show-toplevel'), l:lf, '', 'g'), ':t')
    let l:my_git_branch_name = substitute(system('git branch --show-current'), l:lf, '', 'g')
    let l:ret .= '| ' . l:my_git_repo_name . '/' . l:my_git_branch_name . ' '
  endif

  let l:ret .= '  '
  return l:ret
endfunction
" }}}

" --------------------------------------
" statusline
" {{{
" TODO: inactive window statusline
function! vimrc#statusline() abort
  let l:mode_dict = {
    \ 'n': 'NORMAL',
    \ 'i': 'INSERT',
    \ 'R': 'REPLACE',
    \ 'v': 'VISUAL',
    \ 'V': 'V-LINE',
    \ "\<C-v>": 'V-BLOCK',
    \ 'S': 'S-LINE',
    \ "\<C-s>": 'S-BLOCK',
    \ 's': 'SELECT',
    \ 'c': 'COMMAND',
    \ 't': 'TERMINAL',
    \ }

  let l:ret = ' ' . '[' . l:mode_dict[mode()] . "%{&paste ? '|PASTE' : ''}" . ']' . ' |'
  let l:ret .= ' ' . '%t' . ' |'
  let l:ret .= '%<'
  let l:ret .= "%{&readonly ? ' RO |' : ''}"
  let l:ret .= "%{&modified ? ' + |' : (&readonly ? ' - |' : '')}"
  let l:ret .= "%="
  let l:ret .= '| ' . '%l/%L:%-2c' . ' '
  " let l:ret .= '| ' . '%3p' . "%{'\%'}" . ' '
  " let l:ret .= '| ' . "%{(&expandtab ? 'Spaces:' : 'TabSize:') . &tabstop}" . ' '
  " let l:ret .= '| ' . "%{(&fileformat == 'dos') ? 'CRLF' : ((&fileformat == 'unix') ? 'LF' : ((&fileformat == 'mac') ? 'CR' : ''))}" . ' '
  let l:ret .= '| ' . "%{&fileformat}" . ' '
  let l:ret .= '| ' . "%{(&fileencoding != '') ? &fileencoding : &encoding}" . ' '
  let l:ret .= '| ' . "%{(&filetype == '') ? 'no_ft' : &filetype}" . ' '
  let l:ret .= '  '
  return ret
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

  " https://github.com/vim-jp/issues/issues/1176
  let l:l_vimrc_path = []
  for l:i in reverse(findfile('local.vim', escape(expand(a:path), ' ') . ';', -1))
    call add(l:l_vimrc_path, fnamemodify(l:i, ':p'))
  endfor

  if filereadable(expand('~/.vim/local_sample.vim'))
    source ~/.vim/local_sample.vim
  endif
  for l:i in l:l_vimrc_path
    execute 'source' l:i
  endfor
endfunction

function! vimrc#is_first_load() abort
  let l:dirpath_wo_symbol = substitute(fnamemodify(expand('<sfile>:p:h'), ':p'), '[^a-zA-Z0-9]', '_', 'g')
  if !exists('g:{l:dirpath_wo_symbol}')
    let g:{l:dirpath_wo_symbol} = 1
    return v:true
  else
    return v:false
  endif
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
