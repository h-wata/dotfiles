UsePlugin 'eskk'
let g:eskk#directory = "~/.config/eskk"
let g:eskk#large_dictionary = {'path': "~/.config/eskk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',}

let g:eskk#kakutei_when_unique_candidate = 1 "漢字変換した時に候補が1つの場合、自動的に確定する
let g:eskk#enable_completion = 0             "neocompleteを入れないと、1にすると動作しなくなるため0推奨
let g:eskk#no_default_mappings = 1           "デフォルトのマッピングを削除
let g:eskk#keep_state = 0                    "ノーマルモードに戻るとeskkモードを初期値にする
let g:eskk#egg_like_newline = 1              "漢字変換を確定しても改行しない。

"表示文字を変更(オレ サンカクデ ハンダン デキナイ)
let g:eskk#marker_henkan = "[変換]"
let g:eskk#marker_henkan_select = "[選択]"
let g:eskk#marker_okuri = "[送り]"
let g:eskk#marker_jisyo_touroku = "[辞書]"

augroup vimrc_eskk
  autocmd!
  "markdownは日本語を打つ前提
  autocmd InsertEnter * call s:markdown_eskk()
  autocmd Filetype markdown nnoremap <buffer><silent> <F1> :call <SID>markdown_eskk_toggle()<CR>
augroup END

let g:toggle_markdown_eskk = 1
function! s:markdown_eskk() abort
  if &filetype == 'markdown' && g:toggle_markdown_eskk ==# 1
    call eskk#enable()
  endif
endfunction

function! s:markdown_eskk_toggle() abort
  let g:toggle_markdown_eskk = g:toggle_markdown_eskk == 1 ? 0 : 1
  if g:toggle_markdown_eskk ==# 1
    echomsg 'Markdown日本語入力モードON'
  else
    echomsg 'Markdown日本語入力モードOFF'
  endif
endfunction

augroup vimrc_eskk
  autocmd!
  autocmd User eskk-enable-post lmap <buffer> l <Plug>(eskk:disable)
augroup END

imap jj <Plug>(eskk:toggle)
cmap jj <Plug>(eskk:toggle)


