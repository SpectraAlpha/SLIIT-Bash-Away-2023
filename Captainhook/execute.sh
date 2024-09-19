#!/bin/bash

# Define the hook file path
HOOK_FILE=".git/hooks/commit-msg"
cat << 'EOF' > "$HOOK_FILE"


# Check if ./out directory exists, if not, create it

mkdir ./src/out


# Append the commit message to ./out/commits.txt
cat "\$1" >> ./src/out/commits.txt

# Optionally, add a timestamp for when the commit was made
echo "Committed on \$(date)" >> ./out/commits.txt
echo "" >> ./out/commits.txt # Add an empty line for better readability
EOF

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
