#!/bin/bash

original_dir="$(pwd)"

if [[ "$(basename "$original_dir")" != "daluai-conf" ]]; then
    cd ..
    if [[ "$(basename "$(pwd)")" != "daluai-conf" ]]; then
      echo "Error: Cannot run script from this directory" >&2
      exit 1
    fi
fi

echo "Installing scripts..."
for script in scripts/bin/*; do
  chmod +x $script
  echo "- $script..."
  sudo cp $script $factoryBin
done
echo ""

cd "$original_dir"
