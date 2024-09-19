#!/bin/bash
# List git commits in single line format and pipe to log file
echo "Piping commits to log file"
git log --pretty=format:'%h was %an, %ar, message: %s' > ./log/commits.log