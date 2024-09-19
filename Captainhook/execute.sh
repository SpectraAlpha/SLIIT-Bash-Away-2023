#!/bin/bash
git init
mkdir out
chmod +x .git/hooks/post-commit
chmod 777 out

# Ensure the ./out directory exists, create it if not
if [ ! -d "./out" ]; then
  mkdir -p ./out
fi

# Ensure the ./out/commits.txt file exists, create it if not
if [ ! -f "./out/commits.txt" ]; then
  touch ./out/commits.txt
fi

# Set up the post-commit hook
HOOK_FILE=".git/hooks/post-commit"

cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash

# Log the commit message to ./out/commits.txt
COMMIT_MSG=$(git log -1 --pretty=%B)
mkdir -p ./out
echo "$COMMIT_MSG" >> ./out/commits.txt
EOF

chmod +x "$HOOK_FILE"

echo "Git repository initialized and post-commit hook set up to log commit messages to ./out/commits.txt"