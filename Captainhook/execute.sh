#!/bin/bash
#cd src
# Define the hook file path
HOOK_FILE=".git/hooks/commit-msg"
mkdir -p .git/hooks
cat << 'EOF' > "$HOOK_FILE"


# Check if ./out directory exists, if not, create it

mkdir ./out


# Append the commit message to ./out/commits.txt
cat "\$1" >> ./out/commits.txt

# Optionally, add a timestamp for when the commit was made
# echo "Committed on \$(date)" >> ./out/commits.txt
# echo "" >> ./out/commits.txt # Add an empty line for better readability
EOF
if [ -f "$HOOK_FILE" ]; then
    # Make the hook executable
    chmod +x "$HOOK_FILE"

    echo "commit-msg hook created and made executable."
fi

# Check if the out directory exists, create it if necessary
if [ ! -d "./out" ]; then
    echo "Creating ./out directory..."
    mkdir ./out
else
    echo "./out directory already exists."
fi

echo "Setup complete!"
