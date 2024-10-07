#!/usr/bin/bash
sudo apt update
sudo apt install dconf-cli uuid-runtime
bash -c  "$(wget -qO- https://git.io/vQgMr)"
