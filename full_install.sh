#!/usr/bin/env bash

##
## Install DAluai configuration. Must be run from project folder.
##

# Verify script is being run from correct location
if [ "$(basename "$(pwd)")" != "daluai-conf" ]; then
  echo "Error: current directory is not 'daluai-conf'" >&2
  echo "Please run the install script from the project directory" >&2
  exit 1
fi


install/dotconfigs_install.sh || exit 1  # installed to user and root dotconfig
install/bashconfig_install.sh
source "$HOME"/.bashrc # unsure if this is needed
install/templates_install.sh
install/scripts_install.sh
install/markdown_handler_install.sh
source "$HOME"/.bashrc # this likely does nothing

echo ""
echo "Done"
echo ""
