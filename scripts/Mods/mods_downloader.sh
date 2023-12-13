#!/bin/bash

# Set the MODS_FOLDER
MODS_FOLDER="/home/sdtdserver/serverfiles/Mods"

# Create the Mods folder if it doesn't exist
mkdir -p "$MODS_FOLDER"
mkdir -p "$MODS_FOLDER/tmp"

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
    curl "$url" -SsL -o "${filename}"

    # Check if the download was successful
    if [ $? -eq 0 ]; then
        echo "INFO: Download successful: $filename"

        # Check the file extension and extract accordingly
        if [[ $filename == *.zip ]]; then
            echo "INFO: Extracting $filename using unzip..."
            unzip -q "$filename" -d "$MODS_FOLDER/tmp/$(basename "$filename" .zip)"
            rm "$filename"  # Remove the original zip file
        elif [[ $filename == *.rar ]]; then
            echo "INFO: Extracting $filename using unrar..."
            unrar x -o+ "$filename" "$MODS_FOLDER"
            rm "$filename"  # Remove the original rar file
        else
            echo "WARNING: Unsupported file type. No extraction performed."
        fi

        # Find the folder containing Modinfo.xml case-insensitive
        mod_folder=$(find "$MODS_FOLDER/tmp" -type f -iname "Modinfo.xml" -exec dirname {} \;)
        # Get the folder name
        mod_folder_name=$(basename "$mod_folder")

        if [ -n "$mod_folder" ]; then
            # Remove the old mod version, check if not empty to avoid removing Mods folder
            if [ -n "$mod_folder_name" ]; then
                rm -rf $MODS_FOLDER/"$mod_folder_name"
            fi
            # Move the folder to MODS_FOLDER
            mv "$mod_folder" "$MODS_FOLDER"
            echo "INFO: Mod $mod_folder_name folder moved to $MODS_FOLDER"
        else
            echo "ERROR: Modinfo.xml not found in the extracted files."
            echo "INFO: Aborting $filename from $url"
        fi
        # Remove the extracted files
        rm -rf "$MODS_FOLDER/tmp/$filename"
    else
        echo "ERROR: Failed to download $filename from $url"
    fi
done

rm -rf "$MODS_FOLDER/tmp"
echo "All downloads, extractions, and folder movements completed."
