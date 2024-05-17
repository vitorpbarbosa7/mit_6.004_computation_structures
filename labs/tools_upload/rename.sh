#!/bin/bash

# Iterate over each file in the directory
for file in *; do
    # Check if the file exists and is a regular file
    if [ -f "$file" ]; then
        # Extract the part after the first underscore
        new_name="${file#*_}"
        
        # Rename the file
        mv "$file" "$new_name"
    fi
done
