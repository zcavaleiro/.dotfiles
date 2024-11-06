#!/bin/bash

# Author: https://github.com/zcavaleiro

# Safe exit of script
set -eo pipefail

# Clone the repo to home directory
cd $HOME
if [ -d "$HOME/.dotfiles" ]; then
    echo "Dir ~/.dotfiles already exists, removing it..."
    rm -rf ~/.dotfiles
fi
git clone https://github.com/zcavaleiro/.dotfiles ~/.dotfiles

# creates the symlinks to the system
cd ~/.dotfiles
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig

# Making pull from recent changes, use of alias for shortcut
echo "alias dotfiles='cd ~/.dotfiles && git pull && cd -'" >> ~/.bashrc

# Apply new congiguration changes
source ~/.bashrc
