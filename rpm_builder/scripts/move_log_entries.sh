#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <logfile> <basename>"
  exit 1
fi

logfile=$1
basename_folder=$2

# Check if the provided logfile exists
if [ ! -f "$logfile" ]; then
  echo "Log file '$logfile' does not exist."
  exit 1
fi

# Create the basename folder if it doesn't exist
if [ ! -d "$basename_folder" ]; then
  mkdir "$basename_folder"
  echo "Created folder: $basename_folder"
fi

# Loop through each line in the logfile (excluding the last line)
while IFS= read -r line; do
  # Skip the last line that contains 'blocks'
  if [[ "$line" =~ [0-9]+[[:space:]]+blocks ]]; then
    continue
  fi

  # Skip empty lines or lines that start with './', or '.' or '..'
  if [[ -z "$line" || "$line" == "." || "$line" == ".." || "$line" == ./ ]]; then
    continue
  fi

  # Debug output: Print the line being processed
  echo "Processing line: $line"

  # Convert relative paths to absolute paths if necessary (assuming the current working directory is where the script is run)
  if [[ "$line" == ./* ]]; then
    line=$(realpath "$line")
  fi

  # Check if the path exists before moving
  if [ -e "$line" ]; then
    mv "$line" "$basename_folder/"
    echo "Moved '$line' to '$basename_folder/'"
  else
    echo "Skipping: '$line' parrent folder already moved previously."
  fi
done < "$logfile"
