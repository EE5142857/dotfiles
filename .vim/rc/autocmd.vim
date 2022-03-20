scriptencoding utf-8

" --------------------------------------
" highlight
"
augroup MyHighlight
  autocmd!
  autocmd ColorScheme * call s:my_highlight()
augroup END
function! s:my_highlight() abort
  highlight CursorLine  cterm=underline ctermfg=NONE ctermbg=NONE
  highlight SpellBad    cterm=NONE ctermfg=Magenta ctermbg=NONE
  highlight SpecialKey  cterm=NONE ctermfg=Gray ctermbg=NONE
  highlight Todo        cterm=NONE ctermfg=Black ctermbg=DarkYellow
  highlight Error       cterm=NONE ctermfg=Black ctermbg=124 " Xterm Name: Red3
  if has('nvim')
    highlight Whitespace  cterm=NONE ctermfg=DarkGray ctermbg=NONE
  endif
endfunction

" --------------------------------------
" syntax
"
augroup MySyntax
  autocmd!
  autocmd Syntax * call s:my_syntax()
augroup END
function! s:my_syntax() abort
  call matchadd('Todo', 'TODO:\|FIXME:\|DEBUG:\|NOTE:\|WARNING:')
  call matchadd('Error', '　\|\s\+$\|\[ \]')
endfunction

" --------------------------------------
" filetype
"
augroup MyFileTypeSpecificSettings
  autocmd!
  autocmd FileType css    setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType toml   setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType vim    setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType sql    setlocal shiftwidth=4 softtabstop=4 tabstop=4

  " filetype undefined
  autocmd BufNewFile,BufRead *.mmd        setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.puml,*.pu  setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

" --------------------------------------
" mark
"
augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
  \ if (line("'\"") >= 1) && (line("'\"") <= line("$"))
  \|  execute "normal! g'\""
  \|endif
augroup END

augroup DeleteMarks
  autocmd!
  autocmd BufReadPost * delmarks a-z
  autocmd VimLeavePre * delmarks a-z0-9[]^.<>
augroup END

" --------------------------------------
" register
"
augroup DeleteRegisters
  autocmd!
  autocmd VimLeavePre * call s:delete_registers()
augroup END
function! s:delete_registers() abort
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

augroup UpdateRegisters
  autocmd!
  autocmd BufEnter * call s:update_registers()
augroup END
function! s:update_registers() abort
  " using filename-modifiers
  let @a = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  let @b = substitute(fnamemodify(@%, ':p:h'), '\\', '\/', 'g')
  let @c = substitute(fnamemodify(@%, ':p'), '\/', '\\', 'g')
  let @d = substitute(fnamemodify(@%, ':p:h'), '\/', '\\', 'g')
  let @e = fnamemodify(@%, ':t')
endfunction

" --------------------------------------
" local setting
"
" https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
"
augroup SourceLocalVimrc
  autocmd!
  autocmd BufNewFile,BufReadPost,BufEnter * call s:source_local_vimrc(expand('<afile>'))
augroup END
function! s:source_local_vimrc(path) abort
  if &buftype != ''
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
