if status is-interactive
    starship init fish | source
    if type -q tmux and; and not test -n "$TMUX"
        tmux attach-session -t default; or tmux new-session -s default
    end
	source "$HOME/.cargo/env.fish"
end
