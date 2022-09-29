#/usr/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd) #cd current directory
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang-go
add_bashrc() {
  added=$(grep "$1" ~/.bashrc | wc -l)
  if [ $added -gt 0 ]; then
    echo "'$1' is already exist in ~/.bashrc"
  else
    echo "$1" >> ~/.bashrc
    echo "'$1' was added to ~/.bashrc"
  fi
}
add_bashrc "export GOPATH=$HOME/.go"
source $HOME/.bashrc
go install github.com/mattn/efm-langserver@latest
mkdir $HOME/.config/efm-langserver
ln -sf $SCRIPT_DIR/.config.yaml ~/.config/efm-langserver/config.yaml
