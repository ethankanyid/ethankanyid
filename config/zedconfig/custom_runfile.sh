#!/bin/bash

# Access the full path using ZED_FILE
full_path="$ZED_FILE"

# Extract filename with extension
filename_ext=$(basename "$full_path")

# Extract filename and extension
filename="${filename_ext%.*}"
extension="${filename_ext##*.}"

# Check if Makefile exists in the current directory or if the command was operated on Makefile
if [ -f "Makefile" ]; then
    if [[ "$filename" == "Makefile" ]]; then
        make run && exit
    else
        read -p "A Makefile was found. Do you want to run it? (Y/N): " response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            make run && exit
        fi
    fi
fi

echo "[running $filename_ext]"

# Handle file types based on extension
case "$extension" in
    cpp)
        g++ "$full_path" -o "$filename" && ./"$filename"
        ;;
    c)
        gcc "$full_path" -o "$filename" && ./"$filename"
        ;;
    py)
        python3 "$full_path"
        ;;
    *)
        echo "File type not supported"
        ;;
esac
