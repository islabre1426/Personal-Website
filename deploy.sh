#!/bin/sh

set -eu

if [ -d "_site/" ]; then
	echo "Removing previous build artifact..."
	rm -r _site/
fi

echo "Building artifact..."
npm run build

echo "Copying build artifact to new worktree..."
git worktree add dist website
cp -r _site/* dist

echo "Pushing worktree to git..."
cd dist
git add .
git commit -m "Deployed website"
git push origin website

echo "Removing worktree"
cd ..
rm -r dist

echo "Updating website on remote server..."
ssh personal-server "cd /var/www/html/Personal-Website && git pull"

echo "Deployment successful."
