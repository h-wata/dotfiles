#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd) #cd current directory

bash ./dotfilesLink.sh
bash ./gitconfiglink.sh
bash ./fzf.sh
