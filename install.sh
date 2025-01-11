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

# Variables
daluai_dotconfigs_folder="./dotconfigs"
daluai_dotbashes_folder="./dotbashes"
scripts_install_folder="/usr/local/bin"

# --- nano configuration ---
# verify existence
type nano > /dev/null || {
  sudo apt install nano || sudo pacman -S nano || (echo "Failed to install nano"; exit 1)
}
cp -r $daluai_dotconfigs_folder/nano/nanorc $HOME/.config/nano/nanorc


# --- scripts installation ---
for script in *; do
  chmod +x $script
  echo "Installing $script..."
  cp $script $scripts_install_folder
done

# --- .bash files ---
cat $daluai_dotbashes_folder/bash_aliases >> $HOME/.bash_aliases
cat $daluai_dotbashes_folder/bash_bashrc >> $HOME/.bashrc
cat $daluai_dotbashes_folder/bash_envs >> $HOME/.bash_envs
