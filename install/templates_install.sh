#!/bin/bash

original_dir="$(pwd)"

if [[ "$(basename "$original_dir")" != "daluai-conf" ]]; then
    cd ..
    if [[ "$(basename "$(pwd)")" != "daluai-conf" ]]; then
      echo "Error: Cannot run script from this directory" >&2
      exit 1
    fi
fi

source $HOME/.bash_envs # get internal env variables
echo "Installing templates..."
sudo mkdir -p $scriptTemplates
sudo cp -r scripts/templates/* $scriptTemplates
echo ""

cd "$original_dir"
