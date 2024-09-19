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

# Function to set up git hook
setup_git_hook() {
  HOOK_DIR=".git/hooks"
  HOOK_FILE="$HOOK_DIR/post-commit"

  mkdir -p "$HOOK_DIR"
  cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash
mkdir -p out
git log --pretty=format:"%s" > ./out/commits.txt
EOF

  chmod +x "$HOOK_FILE"
}

# Main script execution
check_bash_files
check_git_repo
log_git_commits
setup_git_hook

echo "Git commits have been logged to out/commits.txt and hook has been set up."