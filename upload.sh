#!/bin/sh

set -eu

artifact="_site/"
remote_host="root@personal-server"
name="Personal-Website"
dest="/srv"

if [ -d "$artifact" ]; then
    echo "Cleaning up old artifact."
    rm -r "$artifact"
fi

echo "Building website."
npm run build

echo "Syncing content to remote server."
cp -r "$artifact" "$name"
ssh "$remote_host" rm -r "$dest/$name"
tar -cz "$name" | ssh "$remote_host" tar -C "$dest" -xz
rm -r "$name"

echo "Successfully uploaded."