#!/bin/bash

daluai_dotbashes_folder="./dotbashes"

echo "Updating .bash files..."
cat $daluai_dotbashes_folder/bash_aliases >> $HOME/.bash_aliases
cat $daluai_dotbashes_folder/bashrc >> $HOME/.bashrc
cat $daluai_dotbashes_folder/bash_envs >> $HOME/.bash_envs
echo ""