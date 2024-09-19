#!/bin/bash
# List git commits in single line format and pipe to log file
echo "Piping commits to log file"
git log --pretty=format:'%s' > ./out/commits.log