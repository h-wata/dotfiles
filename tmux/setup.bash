#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd) #cd current directory
mkdir -p ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf $SCRIPT_DIR/.tmux.conf ~/.tmux.conf
