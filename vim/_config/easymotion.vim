UsePlugin 'vim-easymotion'
" ホームポジションに近いキーを使う let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" 「'」 + 何かにマッピング
let g:EasyMotion_leader_key="'"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
nmap <Leader>f <Plug>(easymotion-s2)

Plugin 'thinca/vim-quickrun'
" Plugin 'gko/vim-coloresque'
Plugin 'ObserverOfTime/coloresque.vim'
let g:coloresque_whitelist = [
        \   'css', 'conf', 'config', 'haml', 'html', 'htmldjango',
        \   'javascript', 'jsx', 'less', 'php',
        \   'postcss', 'pug', 'qml', 'sass',
        \   'scss', 'sh', 'stylus', 'svg',
        \   'typescript', 'vim', 'vue', 'xml']
let g:coloresque_blacklist = []

