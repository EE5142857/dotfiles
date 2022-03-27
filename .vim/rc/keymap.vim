scriptencoding utf-8

let g:mapleader="\<Space>"

nnoremap Q <Nop>
nnoremap q <Nop>
nnoremap Y y$
nnoremap j gj
nnoremap k gk
nnoremap gf gF
tnoremap <C-[> <C-\><C-n>

" quickfix
nnoremap <silent> <Leader>k   :cprevious<CR>
nnoremap <silent> <Leader>j   :cnext<CR>
nnoremap <silent> <Leader>gg  :<C-u>cfirst<CR>
nnoremap <silent> <Leader>G   :<C-u>clast<CR>

" insert
inoremap ,date <C-r>=strftime('%Y-%m-%d %a')<CR>

" https://lambdalisue.hatenablog.com/entry/2015/12/25/000046
nnoremap <Plug>(my-switch) <Nop>
nmap <Leader>s <Plug>(my-switch)
nnoremap <silent> <Plug>(my-switch)b  :<C-u>setlocal scrollbind! scrollbind?<CR>
nnoremap <silent> <Plug>(my-switch)l  :<C-u>setlocal list! list?<CR>
nnoremap <silent> <Plug>(my-switch)p  :<C-u>setlocal paste! paste?<CR>
nnoremap <silent> <Plug>(my-switch)s  :<C-u>setlocal spell! spell?<CR>
nnoremap <silent> <Plug>(my-switch)t  :<C-u>setlocal expandtab! expandtab?<CR>
nnoremap <silent> <Plug>(my-switch)w  :<C-u>setlocal wrap! wrap?<CR>

nnoremap <Plug>(my-edit) <Nop>
nmap <Leader>e <Plug>(my-edit)
nnoremap <silent> <Plug>(my-edit)ec   :edit ++encoding=cp932<CR>
nnoremap <silent> <Plug>(my-edit)ee   :edit ++encoding=euc-jp<CR>
nnoremap <silent> <Plug>(my-edit)eu   :edit ++encoding=utf-8<CR>
nnoremap <silent> <Plug>(my-edit)i    :edit ~/.vim/init.vim<CR>
nnoremap <silent> <Plug>(my-edit)t    :%s/\s\+$//e<CR>

nnoremap <Plug>(my-filer) <Nop>
nmap <Leader>f <Plug>(my-filer)
" nnoremap <silent> <Plug>(my-filer)t   :15Lexplore<CR>
nnoremap <silent> <Plug>(my-filer)b   :edit ~/Desktop/bookmark.md<CR>

nnoremap <Plug>(my-terminal) <Nop>
nmap <Leader>t <Plug>(my-terminal)
