scriptencoding utf-8
" TODO: export to vimrc function
" --------------------------------------
" filetype
" {{{
augroup MyAutocmd
  autocmd!
  " filetype
  autocmd FileType * call vimrc#ft_common()
  autocmd FileType css,mermaid,plantuml,toml call vimrc#ft_sw2()
  autocmd BufEnter *.vim call vimrc#ft_vim()
  autocmd Syntax * call vimrc#syntax()

  " mark
  autocmd BufReadPost * call vimrc#restore_cursor()
  autocmd BufReadPost * delmarks a-z
  autocmd VimLeavePre * delmarks a-z0-9[]^.<>

  " register
  autocmd VimLeavePre * call vimrc#delete_register()
  autocmd BufEnter * call vimrc#update_register()
augroup END
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
  call feedkeys("\<C-\>\<C-n>G")
  call feedkeys("i")
  call feedkeys("java -jar " . l:plantuml_path . " " . l:src_path . " -charset UTF-8 -png\<CR>")
  call feedkeys("\<C-\>\<C-n>G")
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
  call feedkeys("\<C-\>\<C-n>G")
  call feedkeys("i")
  call feedkeys("mmdc -i " . l:src_name. " -o " . l:src_name_wo_ex . ".png\<CR>")
  call feedkeys("\<C-\>\<C-n>G")
  call feedkeys("\<C-w>k")
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
" }}}
