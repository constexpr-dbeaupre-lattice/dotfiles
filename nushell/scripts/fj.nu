def fj [] {
	let dir = (fd . --type d --max-depth 1 --exclude .git "C:/Users/dbeaupre" | fzf --height 60% --layout=reverse --border | str trim)

	if ($dir | is-empty) {
		return
	}

	cd $dir
}
