#!/bin/bash

mkdir -p out
chmod 777 out

commit_hash=$(git rev-parse --short HEAD)
commit_message=$(git log -1 --pretty=%B)
commit_time=$(git log -1 --pretty=%cd)

echo "Commit hash: $commit_hash" >> out/commits.txt
echo "Commit message: $commit_message" >> out/commits.txt
echo "Commit time: $commit_time" >> out/commits.txt
echo "------------------------" >> out/commits.txt

chmod 777 out/commits.txt