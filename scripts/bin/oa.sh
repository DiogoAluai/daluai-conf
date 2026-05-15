#!/usr/bin/env bash

##
## Open all with sdg-open (default handler app)
##


# Check arguments
if [ $# -eq 0 ]; then
    echo "Usage: $(basename $0) files..."
    exit 1
fi


# Loop through all arguments using a for loop
for arg in "$@"; do
  xdg-open "$arg" &
done

