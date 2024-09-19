#!/bin/bash
git init

# Create the commit-msg hook if it doesn't exist
HOOK_FILE=".git/hooks/commit-msg"
SAMPLE_HOOK_FILE=".git/hooks/commit-msg.sample"

if [ -f "$SAMPLE_HOOK_FILE" ]; then
  mv "$SAMPLE_HOOK_FILE" "$HOOK_FILE"
fi


# Ensure the ./out directory exists, create it if not
if [ ! -d "./out" ]; then
  mkdir -p ./out
fi

# Ensure the ./out/commits.txt file exists, create it if not
if [ ! -f "./out/commits.txt" ]; then
  touch ./out/commits.txt
fi

# Make the post-commit hook executable
chmod +x "$POST_COMMIT_HOOK"
echo "post-commit hook created and made executable."


echo "Setup complete!"