#!/bin/sh

set -eu

artifact="_site/"
remote_host="root@personal-server"
name="Personal-Website"
dest="/var/www/html/$name"

if [ -d "$artifact" ]; then
    echo "Cleaning up old artifact."
    rm -r "$artifact"
fi

echo "Building website."
npm run build

echo "Syncing content to remote server."
rsync -av --delete "$artifact" "$remote_host:$dest"

echo "Successfully uploaded."