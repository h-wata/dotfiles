#!/bin/sh

pip install autopep8
pip install cpplint

SCRIPT_DIR=$(cd $(dirname $0); pwd) #cd current directory
mkdir ~/.vim
mkdir -p ~/.config/i3
ln -sf $SCRIPT_DIR/.vimrc ~/.vimrc
ln -sf $SCRIPT_DIR/.screenrc ~/.screenrc
ln -sf $SCRIPT_DIR/ftdetect  ~/.vim
ln -sf $SCRIPT_DIR/bundle ~/.vim
ln -sf $SCRIPT_DIR/snippets ~/.vim
ln -sf $SCRIPT_DIR/vim/_config ~/.vim/
ln -sf $SCRIPT_DIR/i3wm/config ~/.config/i3/
ln -sf $SCRIPT_DIR/i3wm/script ~/.config/i3/
