#!/usr/bin/env bash

##
## Description
##


# Check arguments
if [ $# -lt 1 ]; then
    echo "Usage: $(basename $0) <username>"
    exit 1
fi

# Expecting one argument. Example: kick_pts "pts/0"
kick_pts() {
  if [ $# -lt 1 ]; then
      echo "Bad kick_pts function call"
      exit 1
  fi
  pid=$(ps aux | grep "$1" | grep "\-bash" | grep -v grep | awk '{print $2}')
  echo "Found pid: $pid"
  kill -9 "$pid"
}


username="$1"
who | grep "$username" | awk '{print $2}' | while read pts; do
    kick_pts "$pts"
done
