scriptencoding utf-8

" --------------------------------------
" filetype
"
augroup MyFileTypeSpecificSettings
  autocmd!
  autocmd FileType *
  \ setlocal formatoptions+=n formatoptions-=ro
  \|setlocal foldmethod=indent nofoldenable
  autocmd FileType css,toml,vim
  \ setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType sql
  \ setlocal shiftwidth=4 softtabstop=4 tabstop=4

  " filetype undefined
  autocmd BufNewFile,BufReadPost *.mmd,*,puml,*pu
  \ setlocal shiftwidth=2 softtabstop=2 tabstop=2

  " for sourced *.vim
  autocmd BufEnter *.vim
  \ setlocal formatoptions+=n formatoptions-=ro
  \|setlocal foldmethod=indent nofoldenable
augroup END

" --------------------------------------
" diagram
"
augroup MyPlantUML
  autocmd!
  autocmd BufWritePost *.puml,*.pu call <SID>plantuml_export()
augroup END
function! s:plantuml_export() abort
  let l:plantuml_path = fnamemodify(expand('$USERPROFILE\scoop\apps\plantuml\current\plantuml.jar'), ':p')
  let l:src_path = fnamemodify(@%, ':p')
  call feedkeys("\<C-w>jG")
  call feedkeys("i")
  call feedkeys("java -jar " . l:plantuml_path . " " . l:src_path . " -charset UTF-8 -svg\<CR>")
  call feedkeys("java -jar " . l:plantuml_path . " " . l:src_path . " -charset UTF-8 -png\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("\<C-w>k")
endfunction

augroup MyMermaid
  autocmd!
  autocmd BufWritePost *.mmd call <SID>mermaid_export()
augroup END
function! s:mermaid_export() abort
  let l:src_name = fnamemodify(@%, ':t')
  let l:src_name_wo_ex = fnamemodify(l:src_name, ':r')
  call feedkeys("\<C-w>jG")
  call feedkeys("i")
  call feedkeys("mmdc -i " . l:src_name. " -o " . l:src_name_wo_ex . ".svg\<CR>")
  call feedkeys("mmdc -i " . l:src_name. " -o " . l:src_name_wo_ex . ".png\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("\<C-w>k")
endfunction

" --------------------------------------
" syntax
"
augroup MySyntax
  autocmd!
  autocmd Syntax *
  \ call s:my_highlight()
  \|call s:my_syntax()
augroup END

function! s:my_highlight() abort
  highlight MyTodo      cterm=NONE ctermfg=Black ctermbg=Yellow
  highlight MyTodo      gui=NONE guifg=Black guibg=Yellow
  highlight MyError     cterm=NONE ctermfg=Black ctermbg=Red
  highlight MyError     gui=NONE guifg=Black guibg=Red
  highlight CursorLine  cterm=underline ctermfg=NONE ctermbg=NONE
  highlight CursorLine  gui=underline guifg=NONE guibg=NONE
  highlight SpecialKey  cterm=NONE ctermfg=DarkGray ctermbg=NONE
  highlight SpecialKey  gui=NONE guifg=DarkGray guibg=NONE
  if has('nvim')
    highlight Whitespace  gui=NONE guifg=DarkGray guibg=NONE
    highlight Whitespace  cterm=NONE ctermfg=DarkGray ctermbg=NONE
  endif
endfunction

function! s:my_syntax() abort
  call matchadd('MyTodo', 'TODO:\|FIXME:\|DEBUG:\|NOTE:\|WARNING:')
  call matchadd('MyError', '　\|\s\+$\|\[ \]')
endfunction

" --------------------------------------
" save & load view
"
augroup MyView
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
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
  if &filetype != ''
    let @a = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')
    let @b = substitute(fnamemodify(@%, ':p:h'), '\\', '\/', 'g')
    let @c = substitute(fnamemodify(@%, ':p'), '\/', '\\', 'g')
    let @d = substitute(fnamemodify(@%, ':p:h'), '\/', '\\', 'g')
    let @e = fnamemodify(@%, ':t')
  endif
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
