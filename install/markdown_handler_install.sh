#!/usr/bin/env bash

##
## Installer for custom markdown file handling by xdg-open
##

set -e

original_dir="$(pwd)"

if [[ "$(basename "$original_dir")" != "daluai-conf" ]]; then
    cd ..
    if [[ "$(basename "$(pwd)")" != "daluai-conf" ]]; then
      echo "Error: Cannot run script from this directory" >&2
      cd -
      exit 1
    fi
fi

echo "Installing markdown handler: "
sudo chmod +x markdown-handler/improve_html.py
sudo chmod +x markdown-handler/md-to-html.sh
sudo chmod +x markdown-handler/custom-md-handler.sh
sudo cp markdown-handler/improve_html.py "$DALUAI_CONF_INSTALL_LOCATION"/improve_html
echo "- improve_html"
sudo cp markdown-handler/md-to-html.sh "$DALUAI_CONF_INSTALL_LOCATION"/md-to-html
echo "- md-to-html"
sudo cp markdown-handler/custom-md-handler.sh "$DALUAI_CONF_INSTALL_LOCATION"/custom-md-handler
echo "- custom-md-handler"

tmpFile=$(mktemp)

sed "s|<MD_HANDLER_LOCATION>|$DALUAI_CONF_INSTALL_LOCATION/custom-md-handler|g" markdown-handler/md-handler.desktop > "$tmpFile"
# Using "daluai-md-handler.desktop" name to differentiate from potentially other md handlers
mv "$tmpFile" "$HOME"/.local/share/applications/daluai-md-handler.desktop
echo "- md-handler.desktop"
echo "Setting default markdown handler to daluai-md-handler.desktop"
xdg-mime default "daluai-md-handler.desktop" text/markdown
echo ""



