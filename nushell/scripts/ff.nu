def ff [] {
    let search_dirs = [
        "C:/Users/dbeaupre/notes",
        "C:/Users/dbeaupre/dotfiles"
    ]

    let file = (fd . --type f --hidden --exclude .git ...$search_dirs | fzf --height 60% --layout=reverse --border | str trim)

    if ($file | is-empty) {
        return
    }

    ^nvim $file
}
