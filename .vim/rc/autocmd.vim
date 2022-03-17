scriptencoding utf-8
" --------------------------------------
" highlight
"
augroup MyHighlight
  autocmd!
  autocmd ColorScheme *
  \ highlight CursorLine  cterm=underline ctermfg=NONE ctermbg=NONE
  \|highlight Error       cterm=NONE ctermfg=Black ctermbg=Red
  \|highlight SpecialKey  cterm=NONE ctermfg=DarkGray ctermbg=NONE
  \|highlight SpellBad    cterm=underline ctermfg=NONE ctermbg=NONE
  \|highlight Todo        cterm=NONE ctermfg=Black ctermbg=Yellow
  \|if has('nvim')
  \|  highlight Whitespace  cterm=NONE ctermfg=DarkGray ctermbg=NONE
  \|endif
augroup END

" --------------------------------------
" syntax
"
augroup MySyntax
  autocmd!
  autocmd Syntax *
  \ call matchadd('Todo', 'TODO:\|FIXME:\|DEBUG:\|NOTE:\|WARNING:')
  \|call matchadd('Error', '　\|\s\+$\|\[ \]')
augroup END

" --------------------------------------
" filetype
"
augroup MyFileType
  autocmd!
  " Width 2
  autocmd BufNewFile,BufRead *.mmd        setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufRead *.puml,*.pu  setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType css    setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType toml   setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType vim    setlocal shiftwidth=2 softtabstop=2 tabstop=2

  " Width 4
  autocmd FileType sql    setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END

" --------------------------------------
" other autocommands
"
augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
  \ if (line("'\"") >= 1) && (line("'\"") <= line("$")) && (&ft !~# 'commit')
  \|  exe "normal! g`\""
  \|endif
augroup END

augroup DeleteMarks
  autocmd!
  autocmd BufReadPost * delmarks a-z
augroup END

augroup DeleteRegisters
  autocmd!
  autocmd VimLeavePre *
  \ let regs = split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  \|for r in regs
  \|  call setreg(r, [])
  \|endfor
  \|if has('nvim')
  \|  wshada!
  \|else
  \|  wviminfo!
  \|endif
augroup END

augroup UpdateRegisters
  autocmd!
  " use filename-modifiers
  autocmd BufEnter *
  \ let @a = substitute(fnamemodify(@%, ':p'), '\/', '\\', 'g')
  \|let @b = substitute(fnamemodify(@%, ':p:h'), '\/', '\\', 'g')
  \|let @c = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
  \|let @d = substitute(fnamemodify(@%, ':p:h'), '\\', '\/', 'g')
  \|let @e = fnamemodify(@%, ':t')
augroup END
