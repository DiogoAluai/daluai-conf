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


install/nano_install.sh || exit 1  # installed to user and root dotconfig
install/bashconfig_install.sh      # location specified in bash_envs: HOME environment variable
install/templates_install.sh       # location specified in bash_envs: scriptTemplates
install/scripts_install.sh         # location specified in bash_envs: factoryBin

echo ""
echo "Done"
echo ""
