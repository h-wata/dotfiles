# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gisen/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/gisen/.fzf/bin"
fi

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
# rcd - roscd package
function rcd {
    local package
    package=$(rospack list-names | fzf ) &&
    roscd $(echo "$package")
    echo $PWD
}
# red - rosed
function red {
    local file
    preview="bat  --color=always --style=header,grid --line-range :100 {-1}"
    file=$(find $(rospack find $1) -type f -print 2> /dev/null| fzf -m --ansi --prompt "Select edit files by TAB>" --preview "$preview" --height 100%) &&
    vim "$file"
}
function rtopic {
    local topic
    preview="rostopic info {-1}"
    topic=$(rostopic list| fzf --ansi --prompt "rostopic info >" --preview "$preview" --height 100%) &&
    echo $topic &&
    rostopic $* $topic
}
function rnode {
    local node
    preview="rosnode info {-1}"
    node=$(rosnode list| fzf --ansi --prompt "rosnode info >" --preview "$preview" --height 100%) &&
    echo $node &&
    rosnode $* $node
}
function rparam {
    preview="rosparam get {-1}"
    param=$(rosparam list| fzf --ansi --prompt "rosparam get >" --preview "$preview" --height 100%) &&
    echo $param &&
    rosparam $* $param
}
# fshow - git commit browser
fshow() {
  _gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"  
  _viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --preview="$_viewGitLogLine"  --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
