scriptencoding utf-8

" --------------------------------------
" filetype
" {{{
augroup MyFileTypeSpecific
  autocmd!
  autocmd BufNewFile,BufReadPost * call <SID>filetype_specific()
  autocmd BufEnter *.vim call <SID>vim_specific()
augroup END

function! s:filetype_specific() abort
  if has('nvim')
    setlocal formatoptions+=n formatoptions-=ro
  endif

  setlocal foldmethod=indent nofoldenable
  setlocal autoindent smartindent

  if 0
    setlocal noexpandtab
  else
    setlocal expandtab
  endif

  " shiftwidth
  if (index(['css', 'toml'], &filetype) >= 0)
  \ || (index(['mmd', 'puml', 'pu'], fnamemodify(@%, ':t:r')) >= 0)
    setlocal shiftwidth=2 softtabstop=2 tabstop=2
  else
    setlocal shiftwidth=4 softtabstop=4 tabstop=4
  endif
endfunction

function! s:vim_specific() abort
  if has('nvim')
    setlocal formatoptions+=n formatoptions-=ro
  endif

  setlocal foldmethod=marker nofoldenable
  setlocal autoindent expandtab smartindent
  setlocal shiftwidth=2 softtabstop=2 tabstop=2
endfunction
" }}}

" --------------------------------------
" diagram
" {{{
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
" }}}

" --------------------------------------
" syntax
" {{{
augroup MySyntax
  autocmd!
  autocmd Syntax * call s:my_syntax()
augroup END

function! s:my_syntax() abort
  call matchadd('MyTodo', 'TODO:\|FIXME:\|DEBUG:\|NOTE:\|WARNING:')
  call matchadd('MyError', '　\|\[ \]')
  call matchadd('MySpecial', '\t\|\s\+$') " [		] 
endfunction
" }}}

" --------------------------------------
" save & load view
" {{{
augroup MyView
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
  " autocmd BufWinLeave * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
  " autocmd BufWinEnter * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
augroup END
" }}}

" --------------------------------------
" mark
" {{{
" augroup RestoreCursor
  " autocmd!
  " autocmd BufReadPost *
  "\ if (line("'\"") >= 1) && (line("'\"") <= line("$"))
  "\|  execute "normal! g'\""
  "\|endif
" augroup END

augroup DeleteMarks
  autocmd!
  autocmd BufReadPost * delmarks a-z
  autocmd VimLeavePre * delmarks a-z0-9[]^.<>
augroup END
" }}}

" --------------------------------------
" register
" {{{
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
" }}}

" --------------------------------------
" local setting
"
" https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
" {{{
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
" }}}
