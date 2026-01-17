#!/bin/bash
set -e

# Set the MODS_FOLDER
MODS_FOLDER="/home/sdtdserver/serverfiles/Mods"
TMP_FOLDER="$MODS_FOLDER/tmp"

# Create the Mods folder if it doesn't exist
mkdir -p "$MODS_FOLDER"
mkdir -p "$TMP_FOLDER"

clean_url_input() {
    local input_urls="$1"
    # Remove quotes and potential leading/trailing whitespace, then split by comma or space
    echo "$input_urls" | sed -e 's/^ *//;s/ *$//' | tr -d '"' | tr ',' ' '
}

get_filename() {
    local url="$1"
    local filename
    
    # Extract filename from Content-Disposition header
    filename=$(curl -sIL "$url" | grep -i -o -E 'content-disposition:.*filename="?([^"]*)"?' | sed -E 's/.*filename="?([^"]*)"?/\1/')

    # Fallback to extracting from URL if necessary
    if [ -z "$filename" ]; then
        filename=$(basename "${url%%\?*}")
    fi

    # Clean filename: remove carriage returns and newlines, trim leading/trailing spaces
    echo "$filename" | tr -d '\r\n' | sed -e 's/^ *//;s/ *$//'
}

download_mod() {
    local url="$1"
    local filename="$2"
    echo "INFO: Downloading $filename from $url..."
    curl "$url" -SsL -o "${filename}"
    return $?
}

extract_archive() {
    local filename="$1"
    local target_dir="$2"

    if [[ "$filename" == *.zip ]]; then
        echo "INFO: Extracting $filename using unzip..."
        unzip -q "$filename" -d "$target_dir"
        rm "$filename"
        return 0
    elif [[ "$filename" == *.rar ]]; then
        echo "INFO: Extracting $filename using unrar..."
        unrar x -o+ "$filename" "$MODS_FOLDER" # Unrar goes directly or we handle it via TMP
        rm "$filename"
        return 0
    else
        echo "WARNING: Unsupported file type for $filename. No extraction performed."
        return 1
    fi
}

deploy_mod() {
    local search_path="$1"
    local mod_folder
    local mod_folder_name

    # Find the folder containing Modinfo.xml case-insensitive
    mod_folder=$(find "$search_path" -type f -iname "Modinfo.xml" -exec dirname {} \; | head -n 1)
    
    if [ -n "$mod_folder" ]; then
        mod_folder_name=$(basename "$mod_folder")
        echo "INFO: Found mod folder: $mod_folder_name"
        
        # Remove the old mod version if it exists
        if [ -d "$MODS_FOLDER/$mod_folder_name" ]; then
            echo "INFO: Removing old version of $mod_folder_name"
            rm -rf "$MODS_FOLDER/$mod_folder_name"
        fi
        
        # Move the folder to MODS_FOLDER
        mv "$mod_folder" "$MODS_FOLDER"
        echo "INFO: Mod $mod_folder_name folder moved to $MODS_FOLDER"
        return 0
    else
        echo "ERROR: Modinfo.xml not found in the extracted files."
        return 1
    fi
}

# Process URLs
cleaned_urls=$(clean_url_input "$MODS_URLS")

for url in $cleaned_urls; do
    filename=$(get_filename "$url")
    
    if download_mod "$url" "$filename"; then
        echo "INFO: Download successful: $filename"
        
        # Use a sub-temp dir for this specific download to avoid name collisions if multiple extractions happen
        extract_tmp="$TMP_FOLDER/$(basename "$filename")_ext"
        mkdir -p "$extract_tmp"

        if extract_archive "$filename" "$extract_tmp"; then
            deploy_mod "$extract_tmp"
        else
            echo "INFO: Aborting $filename from $url due to extraction failure or unsupported type."
        fi
        
        # Cleanup extraction temp for this file
        rm -rf "$extract_tmp"
    else
        echo "ERROR: Failed to download $filename from $url"
    fi
done

# Final cleanup
rm -rf "$TMP_FOLDER"
echo "All downloads, extractions, and folder movements completed."
