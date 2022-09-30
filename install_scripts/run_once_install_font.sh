#!/bin/bash

sudo apt-get install -y fonts-font-awesome
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Roboto Mono Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf
