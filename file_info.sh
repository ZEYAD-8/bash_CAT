#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

file_path=$1
if [ ! -e "$file_path" ]; then
    echo "File not found: $file_path"
    exit 1
fi

echo "File Information for: $file_path"
stat "$file_path"
