#!/usr/bin/bash

# Get the project base directory.
project_root_directory=$(tmux run "echo #{pane_start_path}")
cd $project_root_directory

# Get the GitHub repo URL.
github_remote_url=$(git remote get-url origin)

# Open the GitHub repo.
open $github_remote_url || echo "No GitHub remote found for: ${github_remote_url}."
