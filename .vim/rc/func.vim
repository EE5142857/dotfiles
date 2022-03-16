" --------------------------------------
" Command
"
" command! -nargs=1 Silent
"\ execute 'silent !' . <q-args>
"\|execute 'redraw!'
command! -nargs=1 Silent call Silent(<f-args>)
function! Silent(cmd) abort
  execute 'silent !' . a:cmd
  execute 'redraw!'
endfunction

command! -nargs=1 P call P(<f-args>)
function! P(reg) abort
  execute 'let @* = @' . a:reg
endfunction

command! -nargs=1 F call F(<f-args>)
function! F(str) abort
  execute 'vimgrep /' . a:str . '/g **/*.*'
endfunction

command! -nargs=* ArgdoR call ArgdoR(<f-args>)
function! ArgdoR(...) abort
  " :args **/*.*
  execute 'argdo %s/' . a:1 . '/' . a:2 . '/g | update'
  " :argdelete *
endfunction

command! -nargs=* ArgdoRC call ArgdoRC(<f-args>)
function! ArgdoRC(...) abort
  " :args **/*.*
  execute 'argdo %s/' . a:1 . '/' . a:2 . '/gc | update'
  " :argdelete *
endfunction

command! -nargs=0 FixWhitespace call FixWhitespace()
function! FixWhitespace() abort
  execute '%s/\s\+$//e'
endfunction

" --------------------------------------
" Terminal
"
command! -nargs=? T call T(<f-args>)
function! T(...) abort
  execute 'split | wincmd j | resize 5'

  if has('nvim')
    execute 'terminal'
    execute 'startinsert'
  else
    execute 'terminal ++curwin'
  endif

  if a:0 > 0
    call feedkeys(a:1 . "\<CR>")
  endif

  if has('nvim')
    call feedkeys("\<C-\>\<C-n>\<C-w>h")
  endif
endfunction

command! -nargs=? VT call VT(<f-args>)
function! VT(...) abort
  execute 'vsplit | wincmd l'

  if has('nvim')
    execute 'terminal'
    execute 'startinsert'
  else
    execute 'terminal ++curwin'
  endif

  if a:0 > 0
    call feedkeys(a:1 . "\<CR>")
  endif

  if has('nvim')
    call feedkeys("\<C-\>\<C-n>\<C-w>h")
  endif
endfunction

" --------------------------------------
" [Neovim] Terminal Setup
"
function! VTStart() abort
  if !has('nvim')
    return
  endif

  let l:filetype  = &filetype
  let l:fileext   = fnamemodify(@%, ':e')

  if l:fileext == 'ipynb'
    call StartJupyter()
  elseif l:filetype == 'python'
    call StartPython()
  elseif l:filetype == 'sql'
    call StartSQL()
  else
    echo 'unavailavle'
    return
  endif
endfunction

function! StartJupyter() abort
  execute 'wincmd l'
  call feedkeys("i")
  call feedkeys("activate\<CR>")
  call feedkeys("ipython\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! StartPython() abort
  execute 'wincmd l'
  call feedkeys("i")
  call feedkeys("activate\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! StartSQL() abort
  " defined in local.vim
endfunction

" --------------------------------------
" [Neovim] Terminal Execution
"
function! VTExecute() abort
  if !has('nvim')
    return
  endif

  let l:filetype  = &filetype
  let l:fileext   = fnamemodify(@%, ':e')

  if l:fileext == 'ipynb'
    call ExecuteJupyter()
  elseif l:filetype == 'python'
    call ExecutePython()
  elseif l:filetype == 'sql'
    call ExecuteSQL()
  elseif l:filetype == 'r'
    call ExecuteR()
  else
    echo 'unavailavle'
    return
  endif
endfunction

function! ExecuteJupyter() abort
  execute 'IPythonCellExecuteCell'
  execute 'wincmd l'
  call feedkeys("i\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! ExecutePython() abort
  let l:filepath = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')

  execute 'wincmd l'
  call feedkeys("i" . l:filepath . "\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! ExecuteSQL() abort
  let l:filepath = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')

  execute 'wincmd l'
  call feedkeys("i" . "\\i " . l:filepath . "\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! ExecuteR() abort
  let l:filepath = substitute(fnamemodify(@%, ':p'), '\\', '\/', 'g')

  execute 'wincmd l'
  call feedkeys("i" . "rscript --encoding=utf-8 " . l:filepath . "\<CR>")
  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

" --------------------------------------
" Local Settings
"
" https://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
"
function! SourceLocalVimrc(path) abort
  if (&buftype == 'terminal') || (&buftype == 'quickfix')
    return
  endif

  " NOTE: substitute for 'set autochdir'
  " execute 'lcd' fnamemodify(a:path, ':p:h')

  let l:find_list = findfile('local.vim', escape(a:path, ' ') . ';', -1)
  let l:relative_vimrc_list = reverse(l:find_list)
  let l:absolute_vimrc_list = []
  for l:i in l:relative_vimrc_list
    call add(l:absolute_vimrc_list, fnamemodify(l:i, ':p'))
  endfor

  for l:i in l:absolute_vimrc_list
    execute 'source' l:i

    if index(g:sourced_list, l:i) < 0
      call add(g:sourced_list, l:i)
    endif
  endfor
endfunction
