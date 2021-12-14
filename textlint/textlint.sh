#!/bin/sh

sudo npm install -g textlint textlint-rule-preset-ja-technical-writing

SCRIPT_DIR=$(cd $(dirname $0); pwd) #cd current directory
mkdir ~/.vim
ln -sf $SCRIPT_DIR/.textlintrc ~/.textlintrc
