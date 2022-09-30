#!/bin/bash

sudo apt-get update
sudo apt-get install -y ccache tmux nodejs python3-pip
sudo npm install -g textlint textlint-rule-preset-ja-technical-writing
python3 -m pip install cpplint
