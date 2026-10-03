#!/bin/sh

set -eu

directory="_site"
branch="website"

if [ -d "$directory" ]; then
	echo "Removing old build..."
	rm -r "$directory"
fi

echo "Initializing $branch worktree to "$directory"..."
git worktree add "$directory" "$branch"

echo "Building artifact..."
npm run build

echo "Pushing worktree to git..."
cd _site
git add .
git commit -m "Deployed website"
git push origin "$branch"

echo "Refreshing website on remote server..."
ssh personal-server "cd /var/www/html/Personal-Website && git pull"

echo "Deployment successful."

echo "Cleaning up..."
cd ..
git worktree remove "$directory"