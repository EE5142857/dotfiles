set guifont=Ricty_Diminished_Discord:h12:cSHIFTJIS
set guioptions=c

if has('win32')
  set guioptions-=t
endif

augroup GVimAutoCmd
  autocmd!
  autocmd GUIEnter * simalt ~x
augroup END

nnoremap <silent> f[ :call ChangeFontSize(-1)<CR>
nnoremap <silent> f] :call ChangeFontSize(1)<CR>

" Change GVim font size
function! ChangeFontSize(diff) abort
  let l:gui_font = &guifont
  let l:gui_font1 = matchstr(l:gui_font, '.*:h\ze')
  let l:gui_font_size = matchstr(l:gui_font, '.*:h\zs.*\ze:.*')
  let l:gui_font_size_new = l:gui_font_size + a:diff
  let l:gui_font2 = matchstr(l:gui_font, '.*\zs:.*')
  execute "silent set guifont=" . l:gui_font1 . l:gui_font_size_new . l:gui_font2
endfunction
