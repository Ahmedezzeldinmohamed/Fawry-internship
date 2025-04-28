#!/bin/bash

show_help() {
    echo "Usage: $0 [-n] [-v] search_string filename"
}

if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi

options=""
while [[ "$1" == -* ]]; do
    options="$options$1"
    shift
done

if [ $# -lt 2 ]; then
    echo "Error: Missing search string or filename"
    show_help
    exit 1
fi

search="$1"
file="$2"

if [ ! -f "$file" ]; then
    echo "Error: File not found!"
    exit 1
fi

grep_command="grep -i"

if [[ "$options" == *v* ]]; then
    grep_command="$grep_command -v"
fi

if [[ "$options" == *n* ]]; then
    grep_command="$grep_command -n"
fi

$grep_command "$search" "$file"
