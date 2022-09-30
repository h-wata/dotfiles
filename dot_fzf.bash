# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gisen/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/gisen/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/gisen/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/gisen/.fzf/shell/key-bindings.bash"
