UsePlugin 'lightline'
function! LightlineLSPWarnings() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  return l:counts.warning == 0 ? '' : printf('W:%d', l:counts.warning)
endfunction

function! LightlineLSPErrors() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  return l:counts.error == 0 ? '' : printf('E:%d', l:counts.error)
endfunction

function! LightlineLSPOk() abort
  let l:counts =  lsp#get_buffer_diagnostics_counts()
  let l:total = l:counts.error + l:counts.warning
  return l:total == 0 ? 'OK' : ''
endfunction

augroup LightLineOnLSP
  autocmd!
  autocmd User lsp_diagnostics_updated call lightline#update()
augroup END

let g:lightline = {
\'colorscheme': 'Tomorrow_Night',
\'active': {
\  'left': [
\    ['mode', 'paste'], 
\    ['lsp_errors', 'lsp_warnings', 'lsp_ok' ],
\    ['gitbranch', 'readonly', 'filename', 'modified']
\     ],
\ },
\ 'component_function':{
\   'gitbranch': 'FugitiveHead'
\ },
\ 'component_expand':{
\   'lsp_warnings': 'LightlineLSPWarnings',
\   'lsp_errors': 'LightlineLSPErrors',
\   'lsp_ok': 'LightlineLSPOk',
\ },
\ 'component_type':{
\   'lsp_warnings': 'warning',
\   'lsp_errors': 'error',
\   'lsp_ok': 'middle',
\ },
\ }
