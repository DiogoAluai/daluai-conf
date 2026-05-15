#!/usr/bin/env bash

original_dir="$(pwd)"

if [[ "$(basename "$original_dir")" != "daluai-conf" ]]; then
    cd ..
    if [[ "$(basename "$(pwd)")" != "daluai-conf" ]]; then
      echo "Error: Cannot run script from this directory" >&2
      exit 1
    fi
fi

source $HOME/.bash_envs # get internal env variables

echo "Installing scripts..."
for script in scripts/bin/*; do
  chmod +x $script
  echo "- $script"
  # todo: fix python scripts
  script_name=$(basename "$script")
  sudo cp $script $DALUAI_CONF_INSTALL_LOCATION/${script_name%.sh}
done
echo ""

cd "$original_dir"
