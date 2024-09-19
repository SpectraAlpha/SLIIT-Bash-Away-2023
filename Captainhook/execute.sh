#!/bin/bash

# Ensure the .git/hooks directory exists
mkdir -p .git/hooks

# Create the commit-msg hook
HOOK_FILE=".git/hooks/commit-msg"

cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash

# Ensure the ./out directory exists, create it if not
if [ ! -d "./out" ]; then
  mkdir -p ./out
fi

# Ensure the ./out/commits.txt file exists, create it if not
if [ ! -f "./out/commits.txt" ]; then
  touch ./out/commits.txt
fi

# Append the commit message to ./out/commits.txt
cat "$1" >> ./out/commits.txt

# Optionally, add a timestamp for when the commit was made
echo "Committed on $(date)" >> ./out/commits.txt
echo "" >> ./out/commits.txt # Add an empty line for better readability
EOF

# Make the commit-msg hook executable
chmod +x "$HOOK_FILE"
echo "commit-msg hook created and made executable."

# Create the post-commit hook (to stage ./out/commits.txt for the next commit)
POST_COMMIT_HOOK=".git/hooks/post-commit"

cat << 'EOF' > "$POST_COMMIT_HOOK"
#!/bin/bash

# Stage the ./out/commits.txt file for the next commit
if [ -f "./out/commits.txt" ]; then
  git add ./out/commits.txt
fi
EOF

# Make the post-commit hook executable
chmod +x "$POST_COMMIT_HOOK"
echo "post-commit hook created and made executable."

# Ensure that the ./out directory and commits.txt file exist
if [ ! -d "./out" ]; then
  echo "Creating ./out directory..."
  mkdir ./out
fi

if [ ! -f "./out/commits.txt" ]; then
  echo "Creating ./out/commits.txt file..."
  touch ./out/commits.txt
fi

echo "Setup complete!"
