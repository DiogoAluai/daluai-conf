#!/usr/bin/bash

# Check if any arguments are provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory1> <directory2> ... <directoryN>"
  exit 1
fi

output_file="mvn_clean_install.log"

echo "" > $output_file

# Iterate through all provided arguments
for dir in $@; do
  # Check for empty argument
  if [ -z "$dir" ]; then
    echo "Empty argument provided. Skipping..."
    continue
  else
    print-banner "$dir"
    clean-install "$dir" > $output_file || {
      cat "$output_file"
      echo "Failed to clean install: $dir";
      exit 1;
    }
    echo ""
    echo " --- "
    echo "Build successfull"
    echo " --- "
  fi
done
