#!/bin/bash

red=31
green=32
yellow=33
cyan=36
cecho() {
    color=$1
    shift
    echo -e "\e[${color}m$@\e[m"
}

add_bashrc() {
  added=$(grep "$1" ~/.bashrc | wc -l)
  if [ $added -gt 0 ]; then
    cecho $yellow "'$1' is already exist in ~/.bashrc"
  else
    echo "$1" >> ~/.bashrc
    cecho $cyan "'$1' was added to ~/.bashrc"
  fi
}
# install fzf
git clone --depth 1 git@github.com:junegunn/fzf.git ~/.fzf
~/.fzf/install
# install bat fd
wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd-musl_7.4.0_amd64.deb -P /tmp/
wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat-musl_0.12.1_amd64.deb -P /tmp/
sudo dpkg -i  /tmp/fd-musl_7.4.0_amd64.deb /tmp/bat-musl_0.12.1_amd64.deb
