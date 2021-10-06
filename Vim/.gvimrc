if 1
  set guifont=Ricty_Diminished_Discord:h12:cSHIFTJIS
  set guioptions=c
  augroup GVimAutoCmd
    autocmd!
    autocmd GUIEnter * simalt ~x
  augroup END
endif
