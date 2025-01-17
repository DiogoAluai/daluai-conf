#!/bin/bash

scripts_install_folder="$factoryBin"


echo "Installing scripts..."
for script in scripts/bin/*; do
  chmod +x $script
  echo "- $script..."
  sudo cp $script $scripts_install_folder
done
echo ""
