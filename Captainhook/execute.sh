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

# Set up the pre-commit hook
HOOK_FILE=".git/hooks/pre-commit"

cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash

# Check for duplicate Signed-off-by lines
if [ "" != "$(grep '^Signed-off-by: ' "$1" | sort | uniq -c | sed -e '/^[[:space:]]*1[[:space:]]/d')" ]; then
  echo >&2 "Duplicate Signed-off-by lines."
  exit 1
fi

# Log the commit message to ./out/commits.txt
COMMIT_MSG_FILE=$(git log -1 --pretty=%B)
mkdir -p ./out
echo "$COMMIT_MSG_FILE" >> ./out/commits.txt
EOF

chmod +x "$HOOK_FILE"

echo "Git repository initialized and pre-commit hook set up to log commit messages to ./out/commits.txt"