#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd) #cd current directory

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
add_bashrc "export FZF_DEFAULT_OPTS='--height 40% --reverse --border'"
add_bashrc "export FZF_CTRL_T_COMMAND='fd -t f --hidden --follow -d 5 -E .git'"
add_bashrc "export FZF_CTRL_T_OPTS='--preview \"bat  --color=always --style=header,grid --line-range :100 {}\"'"

bash ./dotfilesLink.sh
bash ./gitconfiglink.sh
