#!/bin/bash

# Set up the out directory and commits.txt file
mkdir -p out
touch out/commits.txt


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
  echo "Post-commit hook set up successfully."
else
  echo "Post-commit hook already exists."
fi

echo "Git commit log setup complete. Happy sailing, Captain Hook!"
