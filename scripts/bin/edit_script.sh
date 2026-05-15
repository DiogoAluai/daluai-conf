#!/usr/bin/env bash

#
# Edit scriptFactory scripts.
#

# Check arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 <factory command>"
    exit 1
fi


# Access arguments
script="$1"

# Check if command exists
if [ -f $DALUAI_CONF_INSTALL_LOCATION/$script ]; then
  echo "Command '$script' detected."
  echo "Editing..."
  sudo nano $DALUAI_CONF_INSTALL_LOCATION/$script
else
  echo "Couldn't find '$1' in script factory."
fi
