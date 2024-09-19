#!/bin/bash

# Function to set up git hook
setup_git_hook() {
    HOOK_DIR=".git/hooks"
    HOOK_FILE="$HOOK_DIR/post-commit"

    mkdir -p "$HOOK_DIR"
    cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash
mkdir -p out
git log --pretty=format:"%s" > ./out/commits.txt
EOF

    chmod +x "$HOOK_FILE"
}

# Main script execution
setup_git_hook

echo "Git hook has been set up to log commits to out/commits.txt."
