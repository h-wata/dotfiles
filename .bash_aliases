alias nas_mount='sudo mount.cifs //192.168.129.1/Public /mnt/nas_public -o rw,username=admin'
alias nas2_mount='sudo mount.cifs //192.168.129.2/Public /mnt/robo_nas2 -o rw,username=admin'

function change_ws() {
CUR=$PWD
while [ $CUR != $HOME ]; do
     if [ -f $CUR/devel/setup.bash ]; then
         export CATKIN_WORKSPACE=$CUR
         export USER_PACKAGE_PATH=$CATKIN_WORKSPACE/devel
         source $USER_PACKAGE_PATH/setup.bash
         echo “ROS workspace: $CUR”
         break
     fi
     CUR=`readlink -f $CUR/..`
done
}

function ssh() {
  # tmux起動時
  trap "tmux select-pane -P 'bg=default'" INT EXIT TERM
  if [[ -n $(printenv TMUX) ]] ; then
      # 現在のペインIDを記録
      local pane_id=$(tmux display -p '#{pane_id}')
      # 接続先ホスト名に応じて背景色を切り替え
      tmux select-pane -P 'bg=#04376F'

      # 通常通りssh続行
      command ssh $@

      # デフォルトの背景色に戻す
      tmux select-pane -t $pane_id -P 'default'
  else
      command ssh $@
  fi
}
#----
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
function promps {
    local  BLUE="\[\e[1;34m\]"
    local  RED="\[\e[1;31m\]"
    local  GREEN="\[\e[1;32m\]"
    local  YELLOW="\[\e[1;33m\]"
    local  WHITE="\[\e[00m\]"
    local  GRAY="\[\e[1;37m\]"

    case $TERM in
        xterm*) TITLEBAR='\[\e]0;\W\007\]';;
        *)      TITLEBAR="";;
    esac
    local BASE="\u@\h"
    PS1="${TITLEBAR}${GREEN}${BASE}${WHITE}:${BLUE}\w${RED}\$(parse_git_branch)${BLUE}\$${WHITE} \n"
}
promps
#----
ffmpeg_to_gif(){
  ffmpeg -i $1 -filter_complex "[0:v] fps=10,scale=640:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" $2
}

ide()
{
    tmux split-window -v -p 30
    tmux split-window -h -p 66
    tmux split-window -h -p 50
}
