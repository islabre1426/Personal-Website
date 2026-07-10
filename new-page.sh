#!/bin/sh

set -eu

default_title="Draft"
default_path="src/posts"

help="\
$(basename "$0") [--help] [TITLE] [PATH] [TAGS]
    
Optional argument:
    --help  Show this message, ignoring other parameters
    TITLE   Title of the page (default: $default_title)
    PATH    Folder path to store the page (default: $default_path)
"

case $@ in
    "--help")
        printf "%s\n" "$help"
        exit 0
        ;;
esac

title="${1:-"$default_title"}"
path="${2:-"$default_path"}"

title_slug="$(echo "$title" |\
              sed -E "s/[^a-zA-Z0-9 -]+/-/g; s/ +/-/g" |\
              tr "[[:upper:]]" "[[:lower:]]")"

now="$(date +"%Y-%m-%dT%H:%M:%S%:z")"

template="\
---
title: $title
date: $now
---
"

dest_folder="$path/$title_slug"
dest_file="$dest_folder/index.md"

mkdir -p "$dest_folder"

printf "%s\n" "$template" > "$dest_file"

printf "%s\n" "Created new page $dest_file"