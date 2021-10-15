set shell=/bin/bash
set encoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
set relativenumber
set cursorline
set nocompatible              " be iMproved, required
set wildmenu " コマンドモードの補完
let &t_TI = ""
let &t_TE = ""
filetype off                  " required

"Leader キーをspaceに
let mapleader = "\<Space>"
let g:termdebug_wide= 163

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/runtime/
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-surround
Plugin 'tpope/vim-surround'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" 半角/全角変換
Plugin 'shinchu/hz_ja.vim'
function! HankakuMd()
    let pos = getpos('.')
    " ascii文字を全角から半角に変換
    %HzjaConvert han_ascii
    call setpos('.', pos)
endfunction
" md保存時は自動実行
autocmd BufWrite *.md :call HankakuMd()

" ----For Python editor----
" add indent line
Plugin 'Yggdroot/indentLine'
let g:indentLine_char = '┆'
" let g:indentLine_conceallevel = 2
" Python補完 apt-get install python-jedi
" Plugin 'dense-analysis/ale'
"     let g:ale_echo_msg_error_str = ''
"     let g:ale_echo_msg_warning_str = ''
"     let g:ale_sign_error = ''
"     let g:ale_sign_warning = ''
"     let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"     let g:ale_statusline_format = ['x %d', '⚠ %d', 'ok']
"     let g:ale_lint_on_text_change = 0
"     let g:ale_lint_on_enter = 1
"     let g:ale_cpp_cpplint_options= '--linelength=150 --quiet --filter=-whitespace/braces,-whitespace/tab'
"     let g:ale_python_flake8_options= '--ignore=F401,W503 --max-line-length=120'
"     let g:ale_cpp_cpplint_options= '--linelength=150 --quiet --filter=-whitespace/tab,-whitespace/braces,-legal/copyright'
"     let g:ale_c_clangformat_options= '--style=file'
"     let g:ale_yaml_yamllint_options= '{extends: default, rules: {line-length: {max: 120}, {document-start: disable}}}'
"     let g:ale_textlint_use_global= 1
"     let g:ale_python_autopep8_options= '-a -a --max-line-length=100'
"     let g:ale_linters = {
"     \ 'python' : ['flake8'],
"     \ 'cpp' : ['cpplint'],
"     \ 'xml' : ['xmllint'],
"     \ 'javascript': ['eslint'],
"     \ 'sh': ['shellcheck'],
"     \ 'markdown': ['textlint'],
"     \ }
"     let g:ale_fixers= {
"     \ 'javascript': ['standard'],
"     \ 'xml' : ['xmllint'],
"     \ 'python' : ['autopep8'],
"     \ 'cpp' : ['clang-format'],
"     \ 'markdown': ['textlint'],
"	   \}
" 	let g:ale_fix_on_save = 0
" Tree構造を表示するC-e で表示 :help NERDtree参照
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
nmap ]h <Plug>(GitGutterNextHunk )
nmap [h <Plug>(GitGutterPrevHunk)
nmap <Leader>ha <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterRevertHunk)

" 隠しファイルを表示する
let NERDTreeShowHidden = 1
nnoremap <silent><C-e> :NERDTreeFocusToggle<CR>
" デフォルトでツリーを表示させる
" let g:nerdtree_tabs_open_on_console_startup=1
" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" カーソル移動
Plugin 'easymotion/vim-easymotion'
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" 「'」 + 何かにマッピング
let g:EasyMotion_leader_key="'"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
nmap 's <Plug>(easymotion-s2)

" インターフェイス変更
" airlineが重いのでlightlineを使う
Plugin 'itchyny/lightline.vim'
let g:lightline = {
\'active': {
\  'left': [
\    ['mode', 'paste'],
\    ['gitbranch', 'readonly', 'filename', 'modified'],
\    [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ],
\ },
\ 'component_function':{
\   'gitbranch': 'fugitive#head'
\ },
\ }

Plugin 'maximbaz/lightline-ale'
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
"
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
Plugin 'KabbAmine/vCoolor.vim'
" エディタの分割方向を設定する
set splitbelow
set splitright

" ファイル検索
" Plugin 'iberianpig/ranger-explorer.vim'
" nnoremap <silent><Leader>C :RangerOpenCurrentDir<CR>
" nnoremap <silent><Leader>F :RangerOpenProjectRootDir<CR>

" fzf vim setting
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
nnoremap <silent> ,f :GFiles<CR>
nnoremap <silent> ,F :Files<CR>
nnoremap <silent> ,b :Buffers<CR>
nnoremap <silent> ,l :BLines<CR>
nnoremap <silent> ,h :History<CR>
nnoremap <silent> ,m :Mark<CR>

" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Word completion with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
inoremap <expr> <c-x><c-l> fzf#vim#complete#line({'window': { 'width': 1, 'height': 0.6, 'xoffset': 0.2 }})

" url開く
Plugin 'tyru/open-browser.vim'
" カーソル下のURLや単語をブラウザで開く
nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)

" みんな使っているカラースキーマ
Plugin 'tomasr/molokai'
Plugin 'sjl/badwolf'
Plugin 'w0ng/vim-hybrid'
Plugin 'cocopon/iceberg.vim'

" comment out on/off by \c
Plugin 'tyru/caw.vim'
" caw comment out
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

" ---- For C++ ----
" 関数前で:Doxとうつと自動でコメント挿入
Plugin 'DoxygenToolkit.vim'

" <<<neocomplete and vim-clang setting
" vim-lsp setting
Plugin 'SirVer/ultisnips'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/asyncomplete-buffer.vim'
Plugin 'prabirshrestha/asyncomplete-neosnippet.vim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'thomasfaingnaert/vim-lsp-snippets'
Plugin 'thomasfaingnaert/vim-lsp-ultisnips'

augroup LspEFM
  au!
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'efm-langserver',
    \ 'cmd': {server_info->['/home/gisen/go/bin/efm-langserver', '-c='.$HOME.'/.config/efm-langserver/config.yaml']},
    \ 'whitelist': ['yaml', 'xml', 'cmake'],
    \ })
augroup END

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
autocmd FileType python let g:lsp_diagnostics_enabled=0
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
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_text_prop_enabled = 1 " 

let g:lsp_diagnostics_signs_error = {'text': ''}
let g:lsp_diagnostics_signs_warning = {'text': ''}
let g:lsp_diagnostics_signs_hint= {'text': '?'}

let g:lsp_settings = {
\  'efm-langserver': {'disabled': 0 }
\}

let g:asyncomplete_completion_delay=200
let g:asyncomplete_auto_popup=1
let g:asyncomplete_auto_autocompleteopt=1

autocmd FileType typescript,python setlocal omnifunc=lsp#complete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" for debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:asyncomplete_log_file = expand('~/asyncomplete.log')

Plugin 'Shougo/deoplete.nvim'
if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

Plugin 'Shougo/neosnippet-snippets'

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets/snips'

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" ctags setting>>>
" ファイルタイプ毎 & gitリポジトリ毎にtagsの読み込みpathを変える
function! ReadTags(type)
if a:type == 'cpp'
    let type = 'c++'
    else
        let type = a:type
endif
    try
        execute "set tags=".$HOME."/work/dotfiles/tags_files/".
             \ system("cd " . expand('%:p:h') . "; basename `git rev-parse --show-toplevel` | tr -d '\n'").
             \ "/" . type . "_tags"
    catch
        execute "set tags=./tags/" . type . "_tags;"
    endtry
endfunction

" augroup MakeTagsAutoCmd
"     autocmd!
"     autocmd BufWrite *.py !make -f /home/gisen/work/dotfiles/ctags/Makefile
"     autocmd BufWrite *.cpp !make -f /home/gisen/work/dotfiles/ctags/Makefile
"     autocmd BufWrite *.php !make -f /home/gisen/work/dotfiles/ctags/Makefile
"     autocmd BufWrite *.rb !make -f /home/gisen/work/dotfiles/ctags/Makefile
" augroup END
augroup MakeTagsAutoCmd
    autocmd!
    autocmd FileType python nnoremap <leader>M :!make -f /home/gisen/workspace/dotfiles/ctags/Makefile<CR>
augroup END
nnoremap <leader>M :!make -f /home/gisen/work/dotfiles/ctags/Makefile<CR>

augroup TagsAutoCmd
    autocmd!
    autocmd BufEnter * :call ReadTags(&filetype)
augroup END
set notagbsearch

" [tag jump] カーソルの単語の定義先にジャンプ（複数候補はリスト表示）
nnoremap tj :exe("tjump ".expand('<cword>'))<CR>

" [tag back] tag stack を戻る -> tp(tag pop)よりもtbの方がしっくりきた
nnoremap tb :pop<CR>

" [tag next] tag stack を進む
nnoremap tn :tag<CR>

" [tag vertical] 縦にウィンドウを分割してジャンプ
nnoremap tv :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>

" [tag horizon] 横にウィンドウを分割してジャンプ
nnoremap th :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" [tag tab] 新しいタブでジャンプ
nnoremap tt :tab sp<CR> :exe("tjump ".expand('<cword>'))<CR>

" [tags list] tag list を表示
nnoremap tl :ts<CR>
" <<< ctags setting
" over-vim 置換時の見やすさ改善
Plugin 'osyo-manga/vim-over'
" 全体置換
nnoremap <silent><Space>s :OverCommandLine<CR>%s//g<Left><Left>
" 選択範囲置換
vnoremap <silent><Space>s :OverCommandLine<CR>s//g<Left><Left>
" カーソルしたの単語置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

" Plugin for ROS 
Plugin 'taketwo/vim-ros'
let g:ros_make = 'current'
let g:ros_catkin_make_options = ''
" command list
"   - :A 現在編集してるC++のコードに対応するソースコードorヘッダファイル を自動検索
"   - :roscd
"   - :rosed
" rosのディレクトリをPathに追加
set path+=/opt/ros/melodic/share/**
set path+=~/ros/src/**
" gfでlaunchファイル内で検索するときは先頭の/を除く
autocmd FileType xml :setlocal includeexpr=substitute(v:fname,'^\\/','','')

" Plugin for git 
Plugin 'tpope/vim-fugitive'
" :Gdiff opened as vertical
set diffopt+=vertical
" Statuslineの設定
set laststatus=2
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%{ALEGetStatusLine()}%P
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

Plugin 'godlygeek/tabular'
" For Markdown
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_new_list_item_indent = 0

" Plugin 'gabrielelana/vim-markdown'
Plugin 'kannokanno/previm'
let g:vim_markdown_folding_disabled=1
let g:previm_open_cmd = ''
" nnoremap <silent> <C-v> :PrevimOpen<CR> 
au BufRead,BufNewFile *.md set filetype=markdown
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
":PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Plugin 'mattn/webapi-vim'
" Plugin 'tsuyoshiwada/slack-memo-vim', {'depends': 'mattn/webapi-vim'}
" ~/.vimrc.localにTokenを貼り付けること

Plugin 'ferrine/md-img-paste.vim'
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" release autogroup in MyAutoCmd
 augroup MyAutoCmd
   autocmd!
   augroup END

" ref https://zenn.dev/kouta/articles/87947515bff4da
Plugin 'tyru/eskk.vim'
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


syntax enable
" カラースキーム設定、お好きにどうぞ
set background=dark
colorscheme iceberg
set t_Co=256

" vimrc.localがあればそれも読み込む
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
"vi互換 オフ
set nocompatible

"タブ幅の設定
" TABきーを御した際にタブ文字の代わりにスペース
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

"行番号表示
set number
"検索関係
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

" netrwは常にtree view
let g:netrw_liststyle = 3
" " CVSと.で始まるファイルは表示しない
" let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" " 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" " 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
"編集関係
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start
set clipboard=unnamedplus
" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus,unnamed 
    else
            set clipboard& clipboard+=unnamed
            endif
" ctrl-Cでxsel primaryにコピー
vmap <C-c> :w !xsel -i<CR><CR>
" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile 
"表示関係
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に

"set listchars=tab:>-,trail:-,extends:>>,precedes:<<,nbsp:%,eol:~
set listchars=tab:>-,nbsp:%,eol:~,trail:-,space:.
"マクロ及びキー設定
 " 入力モード中に素早くjkと入力した場合はESCとみなす
inoremap jk <Esc>
inoremap ｊｋ <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>
" "Leader キーをspaceに
"Space+oでnew file
nnoremap <Leader>o :e<CR>
"ファイル保存
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction
" pasteするときにインデントするのを防ぐ
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
          set paste
          return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
" mouseでの操作
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
" insert modeから抜ける時nopasteにセット
autocmd InsertLeave * set nopaste

" vim内のタブ操作
nnoremap <Leader>m :bp<CR>
nnoremap <Leader>n :bn<CR>

"filetype plugin indent on
"
" 入力モードでのカーソル移動
" inoremap <C-> <BS>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>

" 日本語入力時にEscを押すと勝手にIMEがOFFになる

set iminsert=0
set imsearch=0
set imactivatefunc=ImActivate
function! ImActivate(active)
  if a:active
    call system('fcitx-remote -o')
  else
    call system('fcitx-remote -c')
  endif
endfunction
set imstatusfunc=ImStatus
function! ImStatus()
  return system('fcitx-remote')[0] is# '2'
endfunction

" autocmd InsertLeave :call ImInActibate()<CR>
" inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>
inoremap ｊｋ <ESC>
inoremap <ESC>oA <Nop>
inoremap <ESC>oB <Nop>
inoremap <ESC>oC <Nop>
inoremap <ESC>oD <Nop>
