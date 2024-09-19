#!/bin/bash

# Ensure out directory and commits.txt file exist
mkdir -p out
touch out/commits.txt

# Check if we are in a Git repository, if not initialize one
if [ ! -d ".git" ]; then
  echo "No Git repository found. Initializing one..."
  git init
  echo "✔ Git repository initialized."
else
  echo "✔ Git repository already exists."
fi

# Create post-commit hook if it doesn't exist
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

# Function to check if the latest commit was logged in commits.txt
check_commit_logged() {
  latest_commit_info=$(git log -1 --pretty=format:"%h - %an: %s")
  
  if tail -1 out/commits.txt | grep -q "$latest_commit_info"; then
    echo "✔ Commit successfully recorded in out/commits.txt: $latest_commit_info"
  else
    echo "✘ Commit not recorded in out/commits.txt. Please check the hook."
  fi
}

# Make a test commit to check if everything works
git add -A
git commit -m "Test commit"

# Check if the commit was logged
check_commit_logged

echo "✔ Git setup and commit logging complete."