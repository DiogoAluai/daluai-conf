#!/usr/bin/env bash

##
## List available users to kick
##


# Check arguments
if [ $# -ne 0 ]; then
    echo "Usage: $(basename $0)"
    exit 1
fi

who | awk '{print $1}' | uniq

