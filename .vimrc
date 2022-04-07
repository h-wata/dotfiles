set shell=/bin/bash
set encoding=utf-8
set ff=unix
" set fileformats=unix,dos,mac
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
set relativenumber
set cursorline
set nocompatible              " be iMproved, required
set wildmenu " コマンドモードの補完
set wildoptions=pum 
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
" call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/vim-sonictemplate'
let g:sonictemplate_vim_template_dir = [
      \ '~/workspace/my-template/template'
      \]

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
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" カーソル移動
" Plugin 'easymotion/vim-easymotion'
" fzf easymotion
Plugin 'yuki-yano/fuzzy-motion.vim'
Plugin 'KabbAmine/vCoolor.vim'
Plugin 'thinca/vim-quickrun'
" Plugin 'gko/vim-coloresque'
Plugin 'ObserverOfTime/coloresque.vim'
let g:coloresque_whitelist = [
        \   'css', 'conf', 'config', 'haml', 'html', 'htmldjango',
        \   'javascript', 'jsx', 'less', 'php',
        \   'postcss', 'pug', 'qml', 'sass',
        \   'scss', 'sh', 'stylus', 'svg',
        \   'typescript', 'vim', 'vue', 'xml', 'conf']
let g:coloresque_blacklist = []

" エディタの分割方向を設定する
set splitbelow
set splitright

" fzf vim setting
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
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

" vim-lsp setting
Plugin 'SirVer/ultisnips'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/asyncomplete-buffer.vim'
Plugin 'prabirshrestha/asyncomplete-neosnippet.vim'
Plugin 'yami-beta/asyncomplete-omni.vim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'thomasfaingnaert/vim-lsp-snippets'
Plugin 'thomasfaingnaert/vim-lsp-ultisnips'

" インターフェイス変更
" airlineが重いのでlightlineを使う
Plugin 'itchyny/lightline.vim'
Plugin 'popkirby/lightline-iceberg'
Plugin 'Shougo/deoplete.nvim'
if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

Plugin 'Shougo/neosnippet-snippets'

" deno
Plugin 'vim-denops/denops.vim'
Plugin 'vim-denops/denops-helloworld.vim'


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
nnoremap <leader>M :!make -f /home/gisen/workspace/dotfiles/ctags/Makefile<CR>

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
" let g:ros_make = 'current'
let g:ros_catkin_make_options = ''
" rosのディレクトリをPathに追加
set path+=/opt/ros/melodic/share/**
set path+=~/ros/src/**
" gfでlaunchファイル内で検索するときは先頭の/を除く
autocmd FileType xml :setlocal includeexpr=substitute(v:fname,'^\\/','','')

Plugin 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xml,*.launch,*.php,*.vue'
" Plugin for git 
Plugin 'tpope/vim-fugitive'
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
nnoremap <silent> [toggle]p :setl paste!<CR>:setl paste?<CR>
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
" 日本語入力時にEscを押すと勝手にIMEがOFFになる

set iminsert=0
set imsearch=0
set imactivatefunc=ImActivate
inoremap ｊｋ <ESC>
inoremap <ESC>oA <Nop>
inoremap <ESC>oB <Nop>
inoremap <ESC>oC <Nop>
inoremap <ESC>oD <Nop>

" vundle#Bundlesから、match関数を使ってpuginの名前を検索。
" dirを返す。
let s:plugs = get(s:, 'plugs', get(g:, 'vundle#bundles', {}))
function! FindPlugin(name) abort
  let l:plug = s:plugs[match(s:plugs, a:name)]
  return match(s:plugs, a:name) >= 0 ? isdirectory(l:plug["rtpath"]) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

runtime! _config/*.vim
