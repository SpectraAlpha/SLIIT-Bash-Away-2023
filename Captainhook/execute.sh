#!/bin/bash

# Initialize git repository if not already initialized
if [ ! -d ".git" ]; then
  git init
fi

# Ensure the ./out directory exists, create it if not
if [ ! -d "./out" ]; then
  mkdir -p ./out
fi

# Ensure the ./out/commits.txt file exists, create it if not
if [ ! -f "./out/commits.txt" ]; then
  touch ./out/commits.txt
fi

# Set up the commit-msg hook
HOOK_FILE=".git/hooks/commit-msg"

cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash
COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")
echo "$COMMIT_MSG" >> ./out/commits.txt
EOF

chmod +x "$HOOK_FILE"

echo "Git repository initialized and commit-msg hook set up to log commit messages to ./out/commits.txt"