#!/bin/bash

# Install dependancies
sudo apt install -y git build-essential autoconf automake cproto gettext checkinstall
sudo apt install -y libacl1-dev libgpm-dev libgtk-3-dev libtinfo-dev libxmu-dev libxpm-dev libncurses-dev 
sudo apt install -y libperl-dev liblua5.2-0 liblua5.2-dev libluajit-5.1-dev lua5.2 luajit python-dev python3-dev ruby-dev

mkdir $HOME/work
cd $HOME/work

git clone https://github.com/vim/vim.git
cd vim
./configure  --prefix=/usr/local/ --with-features=huge --enable-multibyte --enable-gpm --enable-cscope --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-luainterp --enable-acl --enable-fontset --enable-xim --enable-terminal --enable-fail-if-missing --with-luajit --with-x
make
sudo checkinstall
