scriptencoding utf-8

let g:mapleader="\<Space>"

" nnoremap Q <Nop>
" nnoremap q <Nop>
nnoremap Y y$
" nnoremap j gj
" nnoremap k gk
nnoremap gf gF
tnoremap <C-[> <C-\><C-n>

" delete
" vnoremap d "_d
" nnoremap d "_d
" vnoremap D "_D
" nnoremap D "_D
" vnoremap x "_x
" nnoremap x "_x
" vnoremap s "_s
" nnoremap s "_s

" cut
" nnoremap t d
" vnoremap t x
" nnoremap tt dd
" nnoremap T D

" quickfix
nnoremap <silent> <Leader>k :cprevious<CR>
nnoremap <silent> <Leader>j :cnext<CR>
nnoremap <silent> <Leader>gg :<C-u>cfirst<CR>
nnoremap <silent> <Leader>G :<C-u>clast<CR>

" insert
inoremap ,date <C-r>=strftime('%Y-%m-%d %a')<CR>

" https://lambdalisue.hatenablog.com/entry/2015/12/25/000046
nnoremap <Plug>(my-switch) <Nop>
nmap <Leader>s <Plug>(my-switch)
nnoremap <silent> <Plug>(my-switch)b :<C-u>setlocal scrollbind! scrollbind?<CR>
nnoremap <silent> <Plug>(my-switch)l :<C-u>setlocal list! list?<CR>
nnoremap <silent> <Plug>(my-switch)p :<C-u>setlocal paste! paste?<CR>
nnoremap <silent> <Plug>(my-switch)s :<C-u>setlocal spell! spell?<CR>
nnoremap <silent> <Plug>(my-switch)t :<C-u>setlocal expandtab! expandtab?<CR>
nnoremap <silent> <Plug>(my-switch)w :<C-u>setlocal wrap! wrap?<CR>
" nnoremap <silent> <Plug>(my-switch)f :15Lexplore<CR>

nnoremap <Plug>(my-edit) <Nop>
nmap <Leader>e <Plug>(my-edit)
nnoremap <silent> <Plug>(my-edit)ec :edit ++encoding=cp932<CR>
nnoremap <silent> <Plug>(my-edit)ee :edit ++encoding=euc-jp<CR>
nnoremap <silent> <Plug>(my-edit)eu :edit ++encoding=utf-8<CR>
nnoremap <silent> <Plug>(my-edit)ie :edit ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)is :source ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)t :%s/\s\+$//e<CR>

if has('nvim')
  nnoremap <Plug>(my-terminal) <Nop>
  nmap <Leader>t <Plug>(my-terminal)
  nnoremap <silent> <Plug>(my-terminal)sp :call <SID>t_sp()<CR>
  nnoremap <silent> <Plug>(my-terminal)vs :call <SID>t_vs()<CR>
  nnoremap <silent> <Plug>(my-terminal)su :call <SID>t_setup()<CR>
  nnoremap <silent> <Plug>(my-terminal)e :call <SID>t_execute()<CR>

  function! s:t_sp() abort
    5split
    terminal
    call feedkeys("G\<C-w>k")
  endfunction

  function! s:t_vs() abort
    vsplit
    terminal
    call feedkeys("G\<C-w>h")
  endfunction

  function! s:t_setup() abort
    if fnamemodify(@%, ':e') == 'ipynb'
      call StartJupyter()
    elseif &filetype == 'python'
      call StartPython()
    elseif &filetype == 'sql'
      call StartSQL()
    else
      echo 'unavailavle'
    endif
  endfunction

  function! s:t_execute() abort
    if fnamemodify(@%, ':e') == 'ipynb'
      call ExecuteJupyter()
    elseif &filetype == 'python'
      call ExecutePython()
    elseif &filetype == 'sql'
      call ExecuteSQL()
    elseif &filetype == 'r'
      call ExecuteR()
    else
      echo 'unavailavle'
    endif
  endfunction
endif
