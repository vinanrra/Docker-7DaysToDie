#!/bin/bash

# Set the MODS_FOLDER
MODS_FOLDER="/home/sdtdserver/serverfiles/Mods"

# Create the Mods folder if it doesn't exist
mkdir -p "$MODS_FOLDER"

# Remove quotes and potential leading/trailing whitespace from MODS_URLS
MODS_URLS=$(echo "$MODS_URLS" | sed -e 's/^ *//;s/ *$//' | tr -d '"')

# Split the comma-separated URLs into an array
IFS=', ' read -r -a urls <<< "$MODS_URLS"

# Iterate over the URLs and download/extract/copy each file
for url in "${urls[@]}"; do
    # Extract filename from URL
    filename=$(basename "$url")

    # Download the file
    echo "INFO: Downloading $filename from $url..."
    curl -O "$url"

    # Check if the download was successful
    if [ $? -eq 0 ]; then
        echo "INFO: Download successful: $filename"

        # Check the file extension and extract accordingly
        if [[ $filename == *.zip ]]; then
            echo "INFO: Extracting $filename using unzip..."
            unzip -q "$filename" -d "$MODS_FOLDER"
            rm "$filename"  # Optional: Remove the original zip file
        elif [[ $filename == *.rar ]]; then
            echo "INFO: Extracting $filename using unrar..."
            unrar x -o+ "$filename" "$MODS_FOLDER"
            rm "$filename"  # Optional: Remove the original rar file
        else
            echo "WARNING: Unsupported file type. No extraction performed."
        fi

        # Find the folder containing Modinfo.xml
        mod_folder=$(find "$MODS_FOLDER" -type f -iname "Modinfo.xml" -exec dirname {} \;)

        if [ -n "$mod_folder" ]; then
            # Move the folder to MODS_FOLDER
            mv "$mod_folder" "$MODS_FOLDER"
            echo "INFO: Mod folder moved to $MODS_FOLDER"
        else
            echo "ERROR: Modinfo.xml not found in the extracted files."
            echo "INFO: Aborting $filename from $url"
        fi
        # Remove the extracted files
        rm -rf "$MODS_FOLDER/$filename"
    else
        echo "ERROR: Failed to download $filename from $url"
    fi
done

echo "All downloads, extractions, and folder movements completed."
