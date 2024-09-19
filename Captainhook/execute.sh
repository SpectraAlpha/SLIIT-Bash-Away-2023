#!/bin/bash

git init
git add .
# Ensure the ./out directory exists, create it if not
if [ ! -d "./out" ]; then
  mkdir -p ./out
fi

# Ensure the ./out/commits.txt file exists, create it if not
if [ ! -f "./out/commits.txt" ]; then
  touch ./out/commits.txt
fi

# Set up the commit-msg hook
HOOK_FILE=".git/hooks/post-commit"

cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash
echo "./execute.sh" >> post-commit &&  chmod 77 post-commit
EOF