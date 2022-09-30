#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd) #cd current directory

mkdir -p ~/Documents/git/
ln -sf $SCRIPT_DIR/git/gitmessage.txt ~/Documents/git/.gitmessage.txt
