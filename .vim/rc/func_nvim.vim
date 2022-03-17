if !has('nvim')
  finish
endif

" --------------------------------------
" Keymap
"
nnoremap <silent> <Space>vs :call VTStart()<CR>
nnoremap <silent> <Space>ve :call VTExecute()<CR>

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
  execute 'terminal'
  execute 'startinsert'

  if a:0 > 0
    call feedkeys(a:1 . "\<CR>")
  endif

  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

command! -nargs=? VT call VT(<f-args>)
function! VT(...) abort
  execute 'vsplit | wincmd l'
  execute 'terminal'
  execute 'startinsert'

  if a:0 > 0
    call feedkeys(a:1 . "\<CR>")
  endif

  call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

" --------------------------------------
" Terminal Setup
"
function! VTStart() abort
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
  " execute 'wincmd l'
  " call feedkeys("i")
  " call feedkeys("activate\<CR>")
  " call feedkeys("ipython\<CR>")
  " call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! StartPython() abort
  " execute 'wincmd l'
  " call feedkeys("i")
  " call feedkeys("activate\<CR>")
  " call feedkeys("\<C-\>\<C-n>\<C-w>h")
endfunction

function! StartSQL() abort
  " defined in local.vim
endfunction

" --------------------------------------
" Terminal Execution
"
function! VTExecute() abort
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
" ```vimscript:local.vim
" if index(g:l_sourced_vimrc_path, fnamemodify(@%, ':p')) < 0
"   lcd <sfile>:p:h
"   Silent ctags -R .
" endif
"
" let g:python3_host_prog = 'C:\Users\daiki\scoop\apps\python39\current\python3.exe'
" let g:jupytext_command = 'C:\work\myenv\Scripts\jupytext.exe'
" ```
"
augroup MyLocalVimrc
  autocmd!
  autocmd BufNewFile,BufReadPost,BufEnter * call SourceLocalVimrc(fnamemodify(@%, ':p'))
augroup END

function! SourceLocalVimrc(path) abort
  if (&buftype == 'terminal') || (&buftype == 'quickfix')
    return
  endif

  if !exists('g:l_sourced_vimrc_path')
    let g:l_sourced_vimrc_path = []
  endif

  let l:l_vimrc_path = []
  for l:i in reverse(findfile('local.vim', escape(a:path, ' ') . ';', -1))
    call add(l:l_vimrc_path, fnamemodify(l:i, ':p'))
  endfor

  let g:l_sourced_vimrc_path = uniq(sort(g:l_sourced_vimrc_path + l:l_vimrc_path))

  for l:i in l:l_vimrc_path
    execute 'source' l:i
  endfor
endfunction
