scriptencoding utf-8

" NOTE: vimgrep
  " :vimgrep /word/g **/*.*
" NOTE: argdo
  " :args **/*.*
  " :argdo %s/old/new/g | update
  " :argdo %s/old/new/gc | update
  " :argdelete *
" NOTE: cdo
  " :cdo %s/old/new/g | update
  " :cdo %s/old/new/gc | update
command! -nargs=1 P execute 'let @* = @' . <q-args>
command! -nargs=1 G execute 'grep -ri ' . <q-args> . ' .'
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'
