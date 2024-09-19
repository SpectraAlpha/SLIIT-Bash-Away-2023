#!/bin/bash

# Set up the out directory and commits.txt file
mkdir -p out
touch out/commits.txt

# Function to check if commit messages are being recorded
check_commits_recorded() {
  latest_commit_info=$(git log -1 --pretty=format:"%h - %an: %s")
  if grep -q "$latest_commit_info" out/commits.txt; then
    echo "✔ Commit recorded properly in commits.txt: $latest_commit_info"
  else
    echo "✘ Commit NOT recorded in commits.txt. Please check the hook setup."
  fi
}

# Ensure we are in a Git repository
if [ ! -d ".git" ]; then
  echo "This is not a Git repository. Initializing Git..."
  git init
  if [ $? -eq 0 ]; then
    echo "✔ Git repository initialized successfully."
  else
    echo "✘ Failed to initialize Git repository."
    exit 1
  fi
else
  echo "✔ Git repository already exists."
fi

# Create a post-commit hook in .git/hooks if it doesn't exist
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
  echo "✔ Post-commit hook set up successfully."
else
  echo "✔ Post-commit hook already exists."
fi

# Making a test commit to ensure everything is working
echo "Dummy test file for Git log" > testfile.txt
git add testfile.txt
git commit -m "Initial commit for testing"

# Check if the commit was recorded
check_commits_recorded

echo "✔ Git commit log setup complete. Ready to sail with Captain Hook!"