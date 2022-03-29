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
" highlight
" {{{
function! vimrc#highlight() abort
  highlight CursorLine        cterm=underline ctermfg=NONE ctermbg=NONE
  highlight CursorLine        gui=underline guifg=NONE guibg=NONE
  highlight Folded            cterm=NONE ctermfg=DarkGray ctermbg=NONE
  highlight Folded            gui=NONE guifg=DarkGray guibg=NONE
  highlight EndOfBuffer       cterm=NONE ctermfg=DarkGray ctermbg=NONE
  highlight EndOfBuffer       gui=NONE guifg=DarkGray guibg=NONE
  highlight SpecialKey        cterm=NONE ctermfg=DarkGray ctermbg=NONE
  highlight SpecialKey        gui=NONE guifg=DarkGray guibg=NONE
  highlight SpellBad          cterm=NONE ctermfg=Red ctermbg=NONE
  highlight SpellBad          gui=NONE guifg=Red guibg=NONE
  if has('nvim')
    highlight Whitespace        cterm=NONE ctermfg=DarkGray ctermbg=NONE
    highlight Whitespace        gui=NONE guifg=DarkGray guibg=NONE
  endif

  " statusline
  highlight StatusLine        cterm=NONE ctermfg=Gray ctermbg=Black
  highlight StatusLine        gui=NONE guifg=Gray guibg=Black
  highlight StatusLineNC      cterm=NONE ctermfg=Gray ctermbg=Black
  highlight StatusLineNC      gui=NONE guifg=Gray guibg=Black
  if !has('nvim')
    highlight StatusLineTerm    cterm=NONE ctermfg=Gray ctermbg=Black
    highlight StatusLineTerm    gui=NONE guifg=Gray guibg=Black
    highlight StatusLineTermNC  cterm=NONE ctermfg=Gray ctermbg=Black
    highlight StatusLineTermNC  gui=NONE guifg=Gray guibg=Black
  endif

  " tabline
  highlight TabLine           cterm=NONE ctermfg=DarkGray ctermbg=Black
  highlight TabLine           gui=NONE guifg=DarkGray guibg=Black
  highlight TabLineFill       cterm=NONE ctermfg=Gray ctermbg=Black
  highlight TabLineFill       gui=NONE guifg=Gray guibg=Black
  highlight TabLineSel        cterm=NONE ctermfg=Black ctermbg=DarkGray
  highlight TabLineSel        gui=NONE guifg=Black guibg=DarkGray

  " accent
  highlight User1             cterm=NONE ctermfg=White ctermbg=Black
  highlight User1             gui=NONE guifg=White guibg=Black
endfunction
" }}}

" --------------------------------------
" syntax
" {{{
function! vimrc#syntax() abort
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
" tabline
" https://qiita.com/wadako111/items/755e753677dd72d8036d
" {{{
function! vimrc#tabline() abort
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]
    let no = i
    let mod = getbufvar(bufnr, '&modified') ? ' + ' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    if empty(title)
      let title = '[No Name]'
    endif
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= ((i > 1 ) && (i < tabpagenr())) ? '|' : ''
    let s .= ' ' . no . ' ' . title
    let s .= mod
    let s .= (i > tabpagenr()) ? '|' : ''
    let s .= '%#TabLineFill#'
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLineFill#'
  if has('nvim')
    if gina#component#repo#name() != ''
      let s .= ' ' . "%{(gina#component#repo#name() . '/' . gina#component#repo#branch())}" . ' '
    endif
  endif
  let s .= '  '
  return s
endfunction
" }}}

" --------------------------------------
" statusline
" https://wisteriasec.wordpress.com/2018/08/20/vim-statusline%E3%81%AE%E6%95%B4%E3%81%88%E6%96%B9/
" https://qiita.com/Cj-bc/items/dbe62075474c0e29a777
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

  let l:mode = mode()
  let l:path = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  let l:dirname = fnamemodify(@%, ':p:h:t')
  let l:filename = fnamemodify(@%, ':t')

  let l:ret = '%1* ' . l:mode_dict[l:mode] . "%{&paste ? ' | PASTE' : ''}" . ' %*'
  let l:ret .= '| ' . '%f' . ' '
  let l:ret .= '%<'
  let l:ret .= '| ' . fnamemodify(getcwd(), ':t') . ' '
  let l:ret .= "%{((&readonly == 1) ? '| RO ' : '')}"
  let l:ret .= "%{((&modified == 1) ? '| + ' : ((&readonly == 1) ? '| - ' : ''))}"
  let l:ret .= "%="
  let l:ret .= "%{&fileformat}" . ' '
  let l:ret .= '| ' . "%{((&fileencoding != '') ? &fileencoding : &encoding)}" . ' '
  let l:ret .= '| ' . "%{((&filetype != '') ? &filetype : 'no_ft')}" . ' '
  let l:ret .= '| ' . '%3p' . "%{'\%'}" . ' '
  let l:ret .= '| ' . '%3l:%-2c' . ' '
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
