UsePlugin 'ultisnips'


let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snippets/UltiSnips/']
let g:UltiSnipsExpandTrigger = "<tab>" " Don't automatically set UltiSnips expand, called manually in ExpandSnippetOrCarriageReturn().
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
if has('python3')
    let g:UltiSnipsExpandTrigger="<c-e>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif
