set encoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
set relativenumber
set cursorline
set nocompatible              " be iMproved, required
set wildmenu " コマンドモードの補完
filetype off                  " required

"Leader キーをspaceに
let mapleader = "\<Space>"
let g:termdebug_wide= 163
 
" エディタの分割方向を設定する
set splitbelow
set splitright
colorscheme pablo
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

"Space+oでnew file
nnoremap <Leader>o :e<CR>
"ファイル保存
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c
" vim内のタブ操作
nnoremap <Leader>m :bp<CR>
nnoremap <Leader>n :bn<CR>
