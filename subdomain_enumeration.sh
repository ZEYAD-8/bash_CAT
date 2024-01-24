#!/bin/bash

input_file="domains.txt"
output_file="subdomains.txt"
temp_file="temp_subdomains.txt"
iterations=3

if [ ! -f "$input_file" ]; then
    echo "Input file not found: $input_file"
    exit 1
fi

while IFS= read -r domain; do
    sublist3r -d "$domain" -t "$iterations" -o "$temp_file"
    sort -u "$temp_file" >> "$output_file"
done < "$input_file"

sort -u "$output_file" -o "$output_file"
subdomain_count=$(wc -l < "$output_file")

echo "Total unique subdomains: $subdomain_count"
rm "$temp_file"
