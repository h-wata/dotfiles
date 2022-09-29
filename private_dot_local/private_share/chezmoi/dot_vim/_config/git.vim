UsePlugin 'vim-gitgutter'
nmap ]h <Plug>(GitGutterNextHunk )
nmap [h <Plug>(GitGutterPrevHunk)
nmap <Leader>ha <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterRevertHunk)
" :Gdiff opened as vertical
set diffopt+=vertical
" Statuslineの設定
set laststatus=2
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%{ALEGetStatusLine()}%P
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

