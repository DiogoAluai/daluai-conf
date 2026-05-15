#!/usr/bin/bash

# Check if any arguments are provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory1> <directory2> ... <directoryN>"
  exit 1
fi

output_file="mvn_clean.log"

echo "" > $output_file

# receives one directory as argument, to mvn clean
clean() {
  curr_dir="$(pwd)"
  cd "$1"
  mvn clean || {
  cd "$curr_dir"
    return 1
  }
  cd "$curr_dir"
  return 0
}

# Iterate through all provided arguments
for dir in $@; do
  # Check for empty argument
  if [ -z "$dir" ]; then
    echo "Empty argument provided. Skipping..."
    continue
  else
    print-banner "$dir"
    clean "$dir" || {
      cat "$output_file"
      echo "Failed to clean: $dir";
      exit 1;
    }
    echo ""
    echo " --- "
    echo "Cleansing successfull"
    echo " --- "
  fi
done
