#!/usr/bin/env bash
set -euo pipefail

DISTRIBUTABLE="nvim-linux-x86_64.tar.gz"

# Download latest stable neovim
wget https://github.com/neovim/neovim/releases/download/stable/${DISTRIBUTABLE}

# Extract it here
tar -xzvf ${DISTRIBUTABLE} --one-top-level=./executable --strip-components=1

# Symlink the executable to /usr/bin
sudo ln -s $(dirname $(readlink -f $0))/executable/bin/nvim /usr/bin/nvim

# Symlink the configuration to ~/.config/nvim
ln -s $(dirname $(readlink -f $0)) ~/.config/nvim

# Cleanup
rm ${DISTRIBUTABLE}
