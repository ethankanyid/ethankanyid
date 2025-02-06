#!/bin/bash

# Check if the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Not inside a Git repository. Exiting."
    exit 1
fi

# Check if there are remote connections
remote_count=$(git remote -v | wc -l)

if [ $remote_count -gt 0 ]; then
    # Pull changes from the remote repository
    echo "Fetching the latest changes from the remote repository..."
    git pull
else
    echo "No remote repository found."
fi

# Check if there are any changes to stage
changes=$(git status --porcelain)
echo "$changes"

if [ -z "$changes" ]; then
    echo "No changes to commit. Exiting."
    exit 0
fi

# Prompt for the commit message
echo "Enter your commit message:"
read commit_message

# Commit the changes
echo "Committing changes."
git commit -a -m "$commit_message"

# If there is a remote, push the changes
if [ $remote_count -gt 0 ]; then
    echo "Pushing changes to the remote repository..."
    git push
else
    echo "No remote repository found, skipping push."
fi

echo "Script execution completed."
