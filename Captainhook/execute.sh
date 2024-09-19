#!/bin/bash

git init
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

# Check for duplicate Signed-off-by lines
if [ "" != "$(grep '^Signed-off-by: ' "$1" | sort | uniq -c | sed -e '/^[[:space:]]*1[[:space:]]/d')" ]; then
  echo >&2 "Duplicate Signed-off-by lines."
  exit 1
fi

# Log the commit message to ./out/commits.txt
COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$1")
mkdir -p ./out
echo "$COMMIT_MSG" >> ./out/commits.txt
EOF

chmod +x "$HOOK_FILE"

echo "Git repository initialized and commit-msg hook set up to log commit messages to ./out/commits.txt"