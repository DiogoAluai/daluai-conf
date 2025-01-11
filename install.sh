#!/bin/bash

#
# Install DAluai configuration. Must be run from project folder.
#

if [ "$(basename "$(pwd)")" != "daluai-conf" ]; then
  echo "Error: current directory is not 'daluai-conf'" >&2
  echo "Please run the install script from the project directory" >&2
  exit 1
fi

daluai_dotconfig_folder="./dotconfig"

# --- nano configuration ---
# verify existence
type nano > /dev/null || {
  sudo apt install nano || sudo pacman -S nano || (echo "Failed to install nano"; exit 1)
}
cp -r $daluai_dotconfig_folder/nano/nanorc $HOME/.config/nano/nanorc

