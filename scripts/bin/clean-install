#!/usr/bin/bash

# Check if directory argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Navigate to the specified directory
cd "$1" || { echo "Directory not found: $1"; exit 1; }

print-banner $(basename $1)

# Run mvn clean install
mvn -DskipTests=true clean install

# Check if mvn clean install was successful
if [ $? -eq 0 ]; then
  echo "Build successful"
else
  echo "Build failed"
  exit 1
fi