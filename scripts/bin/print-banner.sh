#!/usr/bin/bash

#
# Print a banner with the specified text
# Usage: print-banner <banner text>
#

if [ -z "$1" ]; then
  echo "Usage: $0 <banner text>"
  exit 1
fi

remove-trailing-slash "$@" | figlet -w $(tput cols) | lolcat
