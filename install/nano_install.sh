#!/bin/bash

original_dir="$(pwd)"

if [[ "$(basename "$original_dir")" != "daluai-conf" ]]; then
    cd ..
    if [[ "$(basename "$(pwd)")" != "daluai-conf" ]]; then
      echo "Error: Cannot run script from this directory" >&2
      exit 1
    fi
fi


daluai_dotconfigs_folder="./dotconfigs"


echo "Setting nano up..."

# verify existence
type nano > /dev/null || {
  sudo apt install nano || sudo pacman -S nano || (echo
    "Failed to install nano" >&2 ; exit 1)
}

mkdir -p $HOME/.config/nano/syntax
sudo mkdir -p /root/.config/nano/syntax

cp $daluai_dotconfigs_folder/nano/nanorc $HOME/.config/nano/nanorc
sudo cp $daluai_dotconfigs_folder/nano/nanorc-root /root/.config/nano/nanorc

cp $daluai_dotconfigs_folder/nano/nanorc-nolinenumbers $HOME/.config/nano/nanorc-nolinenumbers
sudo cp $daluai_dotconfigs_folder/nano/nanorc-nolinenumbers /root/.config/nano/nanorc-nolinenumbers

cp $daluai_dotconfigs_folder/nano/syntax/*.nanorc $HOME/.config/nano/syntax/
sudo cp $daluai_dotconfigs_folder/nano/syntax/*.nanorc /root/.config/nano/syntax/

echo ""

cd "$original_dir"
