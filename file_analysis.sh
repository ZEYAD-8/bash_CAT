#!/bin/bash

# Check if a directory is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if the specified directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory not found."
    exit 1
fi

directory_path="$1"

# Display metadata using ExifTool
echo "### ExifTool Metadata ###"
for file in "$directory_path"/*; do
    echo "File: $file"
    mediainfo "$file"
    echo "----------------------------------"
done


# Display media information using Mediainfo
echo "### Mediainfo ###"
for file in "$directory_path"/*; do
    echo "File: $file"
    mediainfo "$file"
    echo "----------------------------------"
done
