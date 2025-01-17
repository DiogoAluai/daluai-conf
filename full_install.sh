#!/bin/bash

##
## Install DAluai configuration. Must be run from project folder.
##

# Verify script is being run from correct location
if [ "$(basename "$(pwd)")" != "daluai-conf" ]; then
  echo "Error: current directory is not 'daluai-conf'" >&2
  echo "Please run the install script from the project directory" >&2
  exit 1
fi


install/nano_install.sh || exit 1
install/dotbashes_install.sh
install/templates_install.sh
install/scripts_install.sh

echo ""
echo "Done"
echo ""
