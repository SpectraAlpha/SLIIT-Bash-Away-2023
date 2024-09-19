#!/bin/bash

# Function to check if only bash files are present
check_bash_files() {
  for file in *; do
    if [[ ! -d "$file" && "${file##*.}" != "sh" ]]; then
 
      exit 1
    fi
  done
}

# Function to check if a git repository is initialized
check_git_repo() {
  if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then

    exit 1
  fi
}

# Function to log git commits to out/commits.txt
log_git_commits() {
  mkdir -p out
  git log --pretty=format:"%s" > ./out/commits.txt
  if [[ $? -ne 0 ]]; then
    
    exit 1
  fi
}


check_bash_files
check_git_repo
log_git_commits

