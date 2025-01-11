#!/bin/bash

daluai_dotconfigs_folder="./dotconfigs"

# verify existence
type nano > /dev/null || {
  sudo apt install nano || sudo pacman -S nano || (echo
    "Failed to install nano" >&2 ; exit 1)
}

mkdir -p $HOME/.config/nano/syntax

cp $daluai_dotconfigs_folder/nano/nanorc $HOME/.config/nano/nanorc
cp $daluai_dotconfigs_folder/nano/nanorc-nolinenumbers $HOME/.config/nano/nanorc-nolinenumbers
cp $daluai_dotconfigs_folder/nano/syntax/*.nanorc $HOME/.config/nano/syntax
