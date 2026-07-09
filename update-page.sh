#!/bin/sh

set -eu

help="\
$(basename "$0") title
    
Positional arguments:
    title   Change title of the page

Sub-arguments for title:
    PATH    Path of the folder containing page
    TITLE   Title to change
"

if [ $# -eq 0 ]; then
    printf "%s\n" "$help"
    exit 0
fi

input="$1"

shift

case $input in
    "title")
        path="$1"
        title="$2"

        parent_path="$(dirname "$path")"

        title_slug="$(echo "$title" |\
                    sed -E "s/[^a-zA-Z0-9 -]+/-/g; s/ +/-/g" |\
                    tr "[[:upper:]]" "[[:lower:]]")"

        new_path="$parent_path/$title_slug"

        mv "$path" "$new_path"

        sed -i -E "s/^title: (.*)$/title: $title/" "$new_path/index.md"

        printf "%s\n" "Changed title of page inside $path to $title"
        ;;
    
    *)
        printf "%s\n" "$input: command not found"
        exit 1
        ;;
esac