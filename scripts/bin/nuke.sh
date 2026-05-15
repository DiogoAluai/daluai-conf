#!/usr/bin/env bash

##
## Nuke local .m2
## I.e. delete the folder, no bombs are actually involved
##


m2_folder="$HOME/.m2/repository/"

if [ ! -d "$m2_folder" ]; then
  red-echo "Did not find .m2 folder: '$m2_folder'"
  exit 1
fi


read -p "Press any key to drop a nuke in .m2's repository folder (or cancel with ctrl+c)" >&2
echo ""
red-echo "Nuke inbound"
rm -rf "$m2_folder"
echo "It's done..."
echo ""
