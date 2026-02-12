#!/usr/bin/env bash
set -euo pipefail

# Remove the neovim executable symlink
sudo rm -f /usr/bin/nvim

# Remove the configuration symlink
rm -f ~/.config/nvim

# Remove the extracted neovim distribution
rm -rf "$(dirname $(readlink -f $0))/executable"
