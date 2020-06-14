#!/bin/sh
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
wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd-musl_7.4.0_amd64.deb  /tmp/
wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat-musl_0.12.1_amd64.deb  /tmp/
sudo dpkg -i  /tmp/fd-musl_7.4.0_amd64.deb /tmp/bat-musl_0.12.1_amd64.deb
cd ~/work
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
