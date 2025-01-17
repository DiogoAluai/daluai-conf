#!/bin/bash


echo "Installing scripts..."
for script in scripts/bin/*; do
  chmod +x $script
  echo "- $script..."
  sudo cp $script $factoryBin
done
echo ""
