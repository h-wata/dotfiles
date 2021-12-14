UsePlugin 'vim-lsp'
augroup LspEFM
  au!
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'efm-langserver',
    \ 'cmd': {server_info->['/home/gisen/go/bin/efm-langserver', '-c='.$HOME.'/.config/efm-langserver/config.yaml']},
    \ 'whitelist': ['yaml', 'xml', 'cmake', 'markdown', 'sh', 'roslaunch.xml'],
    \ })
augroup END
autocmd BufWritePre CMakeLists.txt,*.xml,*.launch call execute('LspDocumentFormatSync --server=efm-langserver')

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction
augroup lsp_install
      au!
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')
" clangd, cqueryはプロジェクトのcompile_commands.jsonを読んで補完を行うので
" cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ONのオプションでビルドし、
" project root dirにjsonを貼る必要がある
set completeopt+=menuone
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
   \ 'name': 'neosnippet',
   \ 'whitelist': ['*'],
   \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
   \ }))"

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_enabled = v:true
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_text_prop_enabled = 1 " 

let g:lsp_diagnostics_signs_error = {'text': ''}
let g:lsp_diagnostics_signs_warning = {'text': ''}
let g:lsp_diagnostics_signs_hint= {'text': '?'}

let g:lsp_settings = {
\  'efm-langserver': {'disabled': 0 }
\}

" for debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:asyncomplete_log_file = expand('~/asyncomplete.log')
