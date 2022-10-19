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

# install package
sudo apt-get update
sudo apt-get install -y ccache tmux nodejs python3-pip ripgrep curl fonts-font-awesome
sudo npm install -g textlint textlint-rule-preset-ja-technical-writing
python3 -m pip install cpplint
# install bat fd
wget https://github.com/sharkdp/fd/releases/download/v8.4.0/fd-musl_8.4.0_amd64.deb -P /tmp/
wget https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-musl_0.22.1_amd64.deb -P /tmp/
sudo dpkg -i  /tmp/fd-musl_8.4.0_amd64.deb
sudo dpkg -i  /tmp/bat-musl_0.22.1_amd64.deb

# install zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# install i3 packages
sudo add-apt-repository ppa:regolith-linux/release
sudo apt update
sudo apt install i3-gaps rofi compton flameshot

# cp rofi themes
mkdir -p $HOME/.local/share/rofi/themes
cp $HOME/.local/share/rofi-themes-collection/themes/rounded-common.rasi $HOME/.local/share/rofi/themes/
cp $HOME/.local/share/rofi-themes-collection/themes/rounded-nord-dark.rasi $HOME/.local/share/rofi/themes/

# install gh command
curl https://github.com/cli/cli/releases/download/v2.17.0/gh_2.17.0_linux_amd64.deb

# Install vim dependancies
sudo apt install -y git build-essential autoconf automake cproto gettext checkinstall
sudo apt install -y libacl1-dev libgpm-dev libgtk-3-dev libtinfo-dev libxmu-dev libxpm-dev libncurses-dev 
sudo apt install -y libperl-dev liblua5.2-0 liblua5.2-dev libluajit-5.1-dev lua5.2 luajit python-dev python3-dev ruby-dev

mkdir $HOME/work
cd $HOME/work

git clone https://github.com/vim/vim.git
cd vim
./configure  --prefix=/usr/local/ --with-features=huge --enable-multibyte --enable-gpm --enable-cscope --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-luainterp --enable-acl --enable-fontset --enable-xim --enable-terminal --enable-fail-if-missing --with-luajit --with-x
make -j8
sudo checkinstall -y

# Install deno
curl -fsSL https://deno.land/install.sh | sh

# install fzf
~/.fzf/install --all --no-zsh --no-fish

# install go and efm-langserver
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang-go
source $HOME/.bashrc
go install github.com/mattn/efm-langserver@latest
