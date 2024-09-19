#!/bin/bash

# Ensure out directory and commits.txt file exist
mkdir -p out
touch out/commits.txt

# Function to check if a Git repository is initialized
check_git_repo() {
  if [ ! -d ".git" ]; then
    echo "✘ No Git repository found."
    return 1
  else
    echo "✔ Git repository exists."
    return 0
  fi
}

# Validate that only Bash files are present
validate_bash_files() {
  non_bash_files=$(find . -type f ! -name "*.sh" ! -path "./.git/*" -exec basename {} \;)
  if [ -n "$non_bash_files" ]; then
    echo "✘ Non-Bash files found: $non_bash_files"
    exit 1
  else
    echo "✔ Only Bash files are present."
  fi
}

# Create post-commit hook if it doesn't exist
setup_post_commit_hook() {
  HOOK_FILE=".git/hooks/post-commit"

  if [ ! -f "$HOOK_FILE" ]; then
    cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash

# Get the latest commit details
commit_info=$(git log -1 --pretty=format:"%h - %an: %s")

# Append the commit info to the out/commits.txt file
echo "$commit_info" >> out/commits.txt
EOF
    chmod +x "$HOOK_FILE"
    echo "✔ Post-commit hook created."
  else
    echo "✔ Post-commit hook already exists."
  fi
}

# Function to check if the latest commit was logged in commits.txt
check_commit_logged() {
  latest_commit_info=$(git log -1 --pretty=format:"%h - %an: %s")
  
  if tail -n 1 out/commits.txt | grep -q "$latest_commit_info"; then
    echo "✔ Commit successfully recorded in out/commits.txt: $latest_commit_info"
  else
    echo "✘ Commit not recorded in out/commits.txt. Please check the hook."
  fi
}

# Main execution flow

# 1. Check if Git repo exists
if ! check_git_repo; then
  echo "Initializing Git repository..."
  git init
  echo "✔ Git repository initialized."
fi

# 2. Validate that only Bash files are present
validate_bash_files

# 3. Set up post-commit hook
setup_post_commit_hook

# 4. Make a test commit to check if commit logging works
touch testfile.sh
git add testfile.sh
git commit -m "Test commit for validation"

# 5. Check if the commit was recorded in commits.txt
check_commit_logged