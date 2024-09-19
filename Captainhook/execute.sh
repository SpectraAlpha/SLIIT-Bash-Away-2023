#!/bin/bash

# Create commit-msg hook
HOOK_FILE=".git/hooks/commit-msg"
mkdir -p .git/hooks
cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash

# Check if ./out directory exists, if not, create it
mkdir -p ./out

# Append the commit message to ./out/commits.txt
cat "\$1" >> ./out/commits.txt

# Optionally, add a timestamp for when the commit was made
# echo "Committed on \$(date)" >> ./out/commits.txt
EOF

if [ -f "$HOOK_FILE" ]; then
    # Make the hook executable
    chmod +x "$HOOK_FILE"
    echo "commit-msg hook created and made executable."
fi

# Create post-commit hook to auto-stage ./out/commits.txt
POST_COMMIT_HOOK=".git/hooks/post-commit"
cat << 'EOF' > "$POST_COMMIT_HOOK"
#!/bin/bash

# Stage the ./out/commits.txt file for the next commit
if [ -f "./out/commits.txt" ]; then
    git add ./out/commits.txt
fi
EOF

if [ -f "$POST_COMMIT_HOOK" ]; then
    # Make the hook executable
    chmod +x "$POST_COMMIT_HOOK"
    echo "post-commit hook created and made executable."
fi

echo "Setup complete!"
