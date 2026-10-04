#!/usr/bin/env bash

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


daluai_dotconfigs_folder="./dotconfigs"

if [ ! -d "$daluai_dotconfigs_folder" ]; then
    echo "Did not find $daluai_dotconfigs_folder"
    exit 1
fi


# verify existence
type nano > /dev/null || {
  sudo apt install nano || sudo pacman -S nano || (echo
    "Failed to install nano" >&2 ; exit 1)
}

# GIT
if [ ! -e "$HOME/.gitconfig" ]; then
    cp $daluai_dotconfigs_folder/git/gitconfig "$HOME"/.gitconfig
    echo "Installed gitconfig to $HOME/.gitconfig"
    echo "Consider adding user information:"
    echo "\`\`\`"
    echo "[user]"
    echo "        email = someone@email.com"
    echo "        username = user"
    echo "        name = Your Name"
    echo "\`\`\`"
    echo ""
else
    echo "Found gitconfig at '$HOME/.gitconfig', skipping its installation"
fi


# NANO
echo "Ignoring current nano config, setting nano up..."
mkdir -p "$HOME"/.config/nano/syntax
sudo mkdir -p /root/.config/nano/syntax

cp $daluai_dotconfigs_folder/nano/nanorc "$HOME"/.config/nano/nanorc
sudo cp $daluai_dotconfigs_folder/nano/nanorc-root /root/.config/nano/nanorc

cp $daluai_dotconfigs_folder/nano/nanorc-nolinenumbers "$HOME"/.config/nano/nanorc-nolinenumbers
sudo cp $daluai_dotconfigs_folder/nano/nanorc-nolinenumbers /root/.config/nano/nanorc-nolinenumbers

cp $daluai_dotconfigs_folder/nano/syntax/*.nanorc "$HOME"/.config/nano/syntax/
sudo cp $daluai_dotconfigs_folder/nano/syntax/*.nanorc /root/.config/nano/syntax/

# Kitty
if [ ! -d "$HOME/.config/kitty" ]; then
    echo "Installing kitty config"
    cp -r $daluai_dotconfigs_folder/kitty ~/.config/
else
    echo "Found kitty config at '$HOME/.config/kitty', skipping its installation"
fi

# NEOVIM
if [ ! -d "$HOME/.config/nvim" ]; then
    echo "Installing neovim config"
    mkdir -p "$HOME"/.config/
    cp -r $daluai_dotconfigs_folder/nvim ~/.config/
    echo "[INFO] To install neovim download here: https://github.com/neovim/neovim/tags"
    echo "[INFO] To install basedpyright lsp, execute: \`uv tool install basedpyright\`"
    echo "[INFO] To install Ruff (python linter/formatter) see here: https://docs.astral.sh/ruff/installation/"
    echo "[INFO] To install lua language server see here: https://github.com/LuaLS/lua-language-server"
    echo "[INFO] To install bash language server (shellchecker, and shfmt) see here: https://github.com/bash-lsp/bash-language-server (may require altering the command to use specific node version)"
    echo "[INFO] Consider adding config for root user: \`sudo cp -r ~/.config/nvim /root/.config/\`"
else
    echo "Found neovim config at '$HOME/.config/nvim', skipping its installation"
fi
echo ""

cd "$original_dir"
