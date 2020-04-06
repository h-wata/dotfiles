#!/bin/sh

sudo add-apt-repository ppa:jonathonf/vim
sudo apt -y update
sudo apt -y install vim
sudo apt-get -y install flake8
sudo apt-get -y install clang-format-3.6
sudo apt-get -y install python-jedi
sudo apt-get -y install python-pip
sudo apt-get -y install ctags-exuberant
pip install autopep8
pip install cpplint

curl -o flameshot_0.6.0.deb  https://github.com/lupoDharkael/flameshot/releases/download/v0.6.0/flameshot_0.6.0_xenial_x86_64.deb
sudo dpkg -i ./flameshot_0.6.0.deb
SCRIPT_DIR=$(cd $(dirname $0); pwd) #cd current directory
ln -sf $SCRIPT_DIR/.vimrc ~/.vimrc
ln -sf $SCRIPT_DIR/.screenrc ~/.screenrc
ln -sf $SCRIPT_DIR/ftdetect ~/.vim
ln -sf $SCRIPT_DIR/bundle ~/.vim
ln -sf $SCRIPT_DIR/snipets ~/.vim
ln -sf $SCRIPT_DIR/i3wm ~/.config/i3/
