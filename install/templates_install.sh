#!/bin/bash

templates_install_folder="/opt/daluai-conf/"

echo "Installing templates..."
sudo mkdir -p $templates_install_folder
sudo cp -r scripts/templates $templates_install_folder
echo ""
