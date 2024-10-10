# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gisen/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/gisen/.fzf/bin"
fi

# Key bindings
# ------------
source "/home/gisen/.fzf/shell/key-bindings.bash"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/gisen/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/gisen/.fzf/shell/key-bindings.bash"

export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export FZF_CTRL_T_COMMAND='fd -t f --hidden --follow -d 5 -E .git'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'

function ghpl {
    gh pr list| fzf --prompt "pr preview>" --preview "echo {} | awk '{print \$1}' | xargs gh pr view" | awk '{print $1}' | xargs gh pr view $1
}
function ghil {
    gh issue list| fzf --prompt "issue preview>" --preview "echo {} | awk '{print \$1}' | xargs gh issue view" | awk '{print $1}' | xargs gh issue view $1
}
# gadd - set git add files
function gadd {
    local files preview
    preview="git --no-pager diff $* --color=always -- {-1}"
    files=$(git diff $* --name-only | fzf -m --ansi --prompt "Select staging files by TAB>" --preview "$preview" --height 100%) &&
    echo "$files" | xargs -i sh -c "git add $(git rev-parse --show-toplevel)/{}"
    git status
}
# gdiff - find git diff
function gdiff {
    local files preview
    preview="git --no-pager diff $* --color=always -- {-1}"
    files=$(git diff $* --name-only | fzf -m --ansi --prompt "Select staging files by TAB>" --preview "$preview" --height 100%) &&
    echo "$files" | xargs -i sh -c "git diff $(git rev-parse --show-toplevel)/{}"
}
function rtopic {
    local topic
    preview="ros2 topic info {-1} -v"
    topic=$(ros2 topic list| fzf --ansi --prompt "rostopic info >" --preview "$preview" --height 100%) &&  
    echo $topic &&
    ros2 topic $* $topic
}   
function rnode {
    local node
    preview="ros2 node info {-1}"
    node=$(ros2 node list| fzf --ansi --prompt "rosnode info >" --preview "$preview" --height 100%) &&  
    echo $node &&
    ros2 node $* $node
}   
function rparam {
    preview="ros2 param get {-1}"
    param=$(ros2 param list| fzf --ansi --prompt "rosparam get >" --preview "$preview" --height 100%) &&  
    echo $param &&
    ros2 param $* $param
}   
 
