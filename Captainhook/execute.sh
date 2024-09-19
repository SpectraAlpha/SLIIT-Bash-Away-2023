#!/bin/bash

# Function to check if only bash files are present
check_bash_files() {
  for file in *; do
    if [[ ! -d "$file" && "${file##*.}" != "sh" ]]; then
      echo "Error: Non-bash file detected: $file"
      exit 1
    fi
  done
}

# Function to check if a git repository is initialized
check_git_repo() {
  if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a git repository"
    exit 1
  fi
}

# Function to log git commits to out/commits.txt
log_git_commits() {
  mkdir -p out
  git log --pretty=format:"%s" > ./out/commits.txt
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to log git commits"
    exit 1
  fi
}

# Main script execution
check_bash_files
check_git_repo
log_git_commits

# Ensure output is only recorded in ./out/commits.txt
if [[ -s ./out/commits.txt ]]; then
  echo "Git commits have been logged to out/commits.txt"
else
  echo "Error: No commit messages recorded"
  exit 1
fi
