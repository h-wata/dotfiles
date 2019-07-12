set encoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp

set nocompatible              " be iMproved, required
set wildmenu " コマンドモードの補完
filetype off                  " required

"Leader キーをspaceに
let mapleader = "\<Space>"
let g:termdebug_wide= 163

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-surround
Plugin 'tpope/vim-surround'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" Track the engine.
Plugin 'SirVer/ultisnips'


" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" https://github.com/SirVer/ultisnips/issues/519
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir='~/.vim/snipets'
let g:UltiSnipsEditSplit="vertical"
let g:ulti_expand_or_jump_res = 0
function! CleverTab()"{{{
    call UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res
        return ""
    else
        if pumvisible()
            return "\<c-n>"
        else
            return neocomplete#start_manual_complete()
        endif
    endif
endfunction"}}}

inoremap <silent> <tab> <c-r>=CleverTab()<cr>
snoremap <silent> <tab> <esc>:call UltiSnips#ExpandSnippetOrJump()<cr>
" inoremap <silent> <tab> <c-r>=g:UltiSnips_Complete()<cr>
" snoremap <silent> <tab> <esc>:call UltiSnips#ExpandSnippetOrJump()<cr>

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<TAB>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsSnippetDirectories =["snipet","UltiSnips"]
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<C-R>=UltiSnips#ExpandSnippet()"
set runtimepath+=~/.vim/snipets/
" ----For Python editor----
" add indent line
Plugin 'Yggdroot/indentLine'
" Python補完 apt-get install python-jedi
Plugin 'davidhalter/jedi-vim'
" pythonのrename用のマッピングがquickrunとかぶるため回避させる
let g:jedi#rename_command = "<leader>t"
let g:jedi#usages_command = "<leader>h"
let g:jedi#documentation_command= "z"
autocmd FileType python setlocal completeopt-=preview " ポップアップを表示しない
" autopep 
" lint tools for cpp, python, js
" pip install cpplint
" pip install autopep8
" 
Plugin 'w0rp/ale'
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_sign_error = 'E'
    let g:ale_sign_warning = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_statusline_format = ['x %d', '⚠ %d', 'ok']
    let g:ale_lint_on_text_change = 0
    let g:ale_lint_on_enter = 1
    let g:ale_cpp_cpplint_options= '--quiet --filter=-whitespace/tab,-whitespace/braces,-legal/copyright'
    let g:ale_c_clangformat_options= '-style="{BasedOnStyle: Google, IndentWidth: 4, Standard: Cpp11}"'
    let g:ale_python_autopep8_options= '-a -a --max-line-length=100'
    let g:ale_linters = {
       \ 'python' : ['flake8'],
       \ 'cpp' : ['cpplint'],
       \ 'xml' : ['xmllint'],
       \ 'javascript': ['eslint'],
       \ }
    let g:ale_fixers= {
       \ 'javascript': ['prettier'],
       \ 'python' : ['autopep8'],
       \ 'cpp' : ['clang-format'],
       \ 'markdown': [
       \   {buffer, lines -> {'command': 'textlint -c ~/.config/textlintrc -o /dev/null --fix --no-color --quiet %t', 'read_temporary_file': 1}}
       \   ],
	   \}
	let g:ale_fix_on_save = 0
" Tree構造を表示するC-e で表示 :help NERDtree参照
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
" 隠しファイルを表示する
let NERDTreeShowHidden = 1
nnoremap <silent><C-e> :NERDTreeFocusToggle<CR>
" デフォルトでツリーを表示させる
" let g:nerdtree_tabs_open_on_console_startup=1
" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
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
\    ['readonly', 'filename', 'modified'],
\    [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ],
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
" エディタの分割方向を設定する
set splitbelow
set splitright

" ファイル検索
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
" キャッシュを利用して高速検索
let g:ctrlp_use_caching = 1
" vim終了時にキャッシュをクリアしない
let g:ctrlp_clear_cache_on_exit = 0
" # <C-r>でキャッシュをクリアして再検索
let g:ctrlp_prompt_mappings = { 'PrtClearCache()': ['<C-r>'] }
" # 検索の際に200[ms]のウェイトを入れる（１文字入力の度に検索結果がコロコロ変わるのが気に入らないため）
let g:ctrlp_lazy_update = 200
" キャッシュを保持するとgit checkout時にファイル差分があるのでキャッシュクリア
" キャッシュを保持しなくてもagがあれば早い
if executable('ag')
  " sudo apt install silversearcher-ag
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif

" 検索モードを開く
nmap <Leader>f :CtrlP<CR>

" url開く
Plugin 'tyru/open-browser.vim'
" カーソル下のURLや単語をブラウザで開く
nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)

" みんな使っているカラースキーマ
Plugin 'tomasr/molokai'
Plugin 'sjl/badwolf'
Plugin 'w0ng/vim-hybrid'
" comment out on/off by \c
Plugin 'tyru/caw.vim'
" caw comment out
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

" ---- For C++ ----
" 関数前で:Doxとうつと自動でコメント挿入
Plugin 'DoxygenToolkit.vim'
" 自動補完
" Plugin 'Shougo/neocomplete.vim'
" " C++用自動補完
" " Plugin 'justmao945/vim-clang'
"
" " neocomplete and vim-clang setting >>>
" " 'Shougo/neocomplete.vim' {{{
" let g:neocomplete#enable_at_startup = 1
"
" if !exists('g:neocomplete#force_omni_input_patterns')
"   let g:neocomplete#force_omni_input_patterns = {} 
" endif
" let g:neocomplete#force_overwrite_completefunc = 1
" let g:neocomplete#force_omni_input_patterns.c =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
" let g:neocomplete#force_omni_input_patterns.cpp =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" let g:neocomplete#enable_smart_case = 1
" " 3文字以上の単語に対して補完を有効にする
" let g:neocomplete#min_keyword_length = 3
" " 区切り文字まで補完する
" let g:neocomplete#enable_auto_delimiter = 1
" " 1文字目の入力から補完のポップアップを表示
" let g:neocomplete#auto_completion_start_length = 1
" " バックスペースで補完のポップアップを閉じる
" inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
"
" }}}
"
" 'justmao945/vim-clang' {{{

" " disable auto completion for vim-clang
" let g:clang_auto = 0
" " default 'longest' can not work with neocomplete
" let g:clang_c_completeopt   = 'menuone'
" let g:clang_cpp_completeopt = 'menuone'
"
" function! s:get_latest_clang(search_path)
"     let l:filelist = split(globpath(a:search_path, 'clang-*'), '\n')
"     let l:clang_exec_list = []
"     for l:file in l:filelist
"         if l:file =~ '^.*clang-\d\.\d$'
"             call add(l:clang_exec_list, l:file)
"         endif
"     endfor
"     if len(l:clang_exec_list)
"         return reverse(l:clang_exec_list)[0]
"     else
"         return 'clang'
"     endif
" endfunction
"
" function! s:get_latest_clang_format(search_path)
"     let l:filelist = split(globpath(a:search_path, 'clang-format-*'), '\n')
"     let l:clang_exec_list = []
"     for l:file in l:filelist
"         if l:file =~ '^.*clang-format-\d\.\d$'
"             call add(l:clang_exec_list, l:file)
"         endif
"     endfor
"     if len(l:clang_exec_list)
"         return reverse(l:clang_exec_list)[0]
"     else
"         return 'clang-format'
"     endif
" endfunction
"
" let g:clang_exec = s:get_latest_clang('/usr/bin')
" let g:clang_format_exec = s:get_latest_clang_format('/usr/bin')
"
" let g:clang_c_options = '-std=c11'
" let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'


" }}}
" <<<neocomplete and vim-clang setting
" vim-lsp setting
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'pdavydov108/vim-lsp-cquery'
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fv :LspCqueryDerived<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fc :LspCqueryCallers<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fb :LspCqueryBase<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fi :LspCqueryVars<CR>

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
if executable('clangd')
    au User lsp_setup call lsp#register_server({
       \ 'name': 'clangd',
       \ 'cmd': {server_info->['clangd']},
       \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
       \ })
endif
if executable('cquery')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->['cquery']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}

let g:asyncomplete_completion_delay=10

autocmd FileType typescript setlocal omnifunc=lsp#complete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

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

augroup MackTagsAutoCmd
    autocmd!
    autocmd BufWrite *.py !make -f /home/gisen/work/dotfiles/ctags/Makefile
    autocmd BufWrite *.cpp !make -f /home/gisen/work/dotfiles/ctags/Makefile
    autocmd BufWrite *.php !make -f /home/gisen/work/dotfiles/ctags/Makefile
    autocmd BufWrite *.rb !make -f /home/gisen/work/dotfiles/ctags/Makefile
augroup END

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
" Plugin 'taketwo/vim-ros'
" let g:ros_make = 'current'
" let g:ros_build_system = 'catkin-tools'
" let g:ros_catkin_make_options = ''
" command list
"   - :A 現在編集してるC++のコードに対応するソースコードorヘッダファイル を自動検索
"   - :roscd
"   - :rosed
" rosのディレクトリをPathに追加
set path+=/opt/ros/kinetic/share/**
set path+=~/ros/src/**
" gfでlaunchファイル内で検索するときは先頭の/を除く
autocmd FileType xml :setlocal includeexpr=substitute(v:fname,'^\\/','','')

" Plugin for git 
Plugin 'tpope/vim-fugitive'
" :Gdiff opened as vertical
set diffopt+=vertical
" Statuslineの設定
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%{ALEGetStatusLine()}%P
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" For Markdown
Plugin 'godlygeek/tabular'

Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_conceal = 0

" Plugin 'gabrielelana/vim-markdown'
Plugin 'kannokanno/previm'
let g:vim_markdown_folding_disabled=1
let g:previm_open_cmd = ''
" nnoremap <silent> <C-v> :PrevimOpen<CR> 
au BufRead,BufNewFile *.md set filetype=markdown
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gisen/.vim/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
	" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

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

" release autogroup in MyAutoCmd
 augroup MyAutoCmd
   autocmd!
   augroup END

syntax enable
" カラースキーム設定、お好きにどうぞ
set background=dark
colorscheme hybrid
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
set listchars=tab:>-,nbsp:%,eol:~,trail:-
"マクロ及びキー設定
 " 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>
inoremap っｊ <Esc>

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
" let mapleader = "\<Space>"
"Space+oでnew file
nnoremap <Leader>o :e<CR>
"ファイル保存
nnoremap <Leader>w :w<CR>
" nnoremap <Leader>q :q<CR>

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
" clang-format必須 C++整形
" function! CPPCodeCleanup()
"   " echo "Cleanup cpp code"
"   let l:lines="all"
"   let g:clang_format_fallback_style = 'Google'
"   :pyf /usr/local/share/clang/clang-format.py
" endfunction
" command! CPPCodeCleanup call CPPCodeCleanup()
"
" autocmd BufWrite *.{cpp} :CPPCodeCleanup
" autocmd BufWrite *.{hpp} :CPPCodeCleanup
" autocmd BufWrite *.{c} :CPPCodeCleanup
" autocmd BufWrite *.{h} :CPPCodeCleanup

" vim内のタブ操作
nnoremap <Leader>m :bp<CR>
nnoremap <Leader>n :bn<CR>

"filetype plugin indent on
"
" 入力モードでのカーソル移動
inoremap <C-d> <BS>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>
inoremap っｊ <Esc>

" 日本語入力時にEscを押すと勝手にIMEがOFFになる

function! ImInActivate()
  call system('fcitx-remote -c')
endfunction
inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>
inoremap っｊ <ESC>:call ImInActivate()<CR>
