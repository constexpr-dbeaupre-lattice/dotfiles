#!/usr/bin/bash

DIRECTORIES=(
	"$HOME"
	"$HOME/scripts"
)

# One argument was provided, select it as a directory.
if [[ $# -eq 1 ]]; then
    selected=$1
else
	selected=$(fdfind . "${DIRECTORIES[@]}" --type directory --max-depth 1 --full-path --base-directory $HOME | sed "s|^$HOME/||" | fzf)
    # Add $HOME back to the selected directory.
    [[ $selected ]] && selected="$HOME/$selected"
fi

# Early exit if no directory is selected.
[[ ! $selected ]] && exit 0

# Replace '.' with '_' since '.' is not valid in session names.
selected_name=$(basename "$selected" | tr . _)

tmux_running=$(pgrep tmux)

# If tmux is not running, create a new session for the selected directory.
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

# If there's no session for the current directory, create it.
if ! tmux has-session -t "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

# Switch to the selected directory.
tmux switch-client -t "$selected_name"
