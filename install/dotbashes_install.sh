#!/bin/bash

original_dir="$(pwd)"

if [[ "$(basename "$original_dir")" != "daluai-conf" ]]; then
    cd ..
    if [[ "$(basename "$(pwd)")" != "daluai-conf" ]]; then
      echo "Error: Cannot run script from this directory" >&2
      exit 1
    fi
fi


daluai_dotbashes_folder="./dotbashes"

echo "Updating .bash files..."
cat $daluai_dotbashes_folder/bash_aliases >> $HOME/.bash_aliases
cat $daluai_dotbashes_folder/bashrc >> $HOME/.bashrc
cat $daluai_dotbashes_folder/bash_envs >> $HOME/.bash_envs
echo ""

cd "$original_dir"
