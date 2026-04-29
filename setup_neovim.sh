#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")"

DISTRIBUTABLE="nvim-linux-x86_64.tar.gz"
LOCKFILE=".nvim-version"
EXECUTABLE_DIR="executable"

# Determine the version we want installed.
if [[ -f "$LOCKFILE" ]]; then
  DESIRED_VERSION=$(tr -d '[:space:]' < "$LOCKFILE")
  echo "Using pinned version from $LOCKFILE: $DESIRED_VERSION"
else
  echo "No $LOCKFILE found; resolving 'stable' to a concrete tag..."
  DESIRED_VERSION=$(curl -fsI https://github.com/neovim/neovim/releases/tag/stable \
    | awk -F'tag/' 'tolower($1) ~ /^location:/ { print $2 }' | tr -d '[:space:]')
  if [[ -z "$DESIRED_VERSION" ]]; then
    echo "Failed to resolve stable tag" >&2
    exit 1
  fi
  echo "Resolved stable to: $DESIRED_VERSION"
fi

# What's currently extracted?
INSTALLED_VERSION=""
if [[ -x "$EXECUTABLE_DIR/bin/nvim" ]]; then
  INSTALLED_VERSION=$("$EXECUTABLE_DIR/bin/nvim" --version | head -n1 | awk '{print $2}')
fi

if [[ "$INSTALLED_VERSION" == "$DESIRED_VERSION" ]]; then
  echo "Neovim $INSTALLED_VERSION already installed."
else
  echo "Installing Neovim $DESIRED_VERSION (was: ${INSTALLED_VERSION:-none})"
  rm -f "${DISTRIBUTABLE}"*
  wget "https://github.com/neovim/neovim/releases/download/${DESIRED_VERSION}/${DISTRIBUTABLE}"
  rm -rf "$EXECUTABLE_DIR"
  tar -xzf "$DISTRIBUTABLE" --one-top-level="$EXECUTABLE_DIR" --strip-components=1
  rm -f "$DISTRIBUTABLE"
fi

# Persist the pin (only writes if absent — preserves manual edits).
if [[ ! -f "$LOCKFILE" ]]; then
  echo "$DESIRED_VERSION" > "$LOCKFILE"
fi

# First-time setup: symlink the binary into PATH.
if [[ ! -e /usr/bin/nvim ]]; then
  echo "Creating /usr/bin/nvim symlink..."
  sudo ln -s "$(pwd)/$EXECUTABLE_DIR/bin/nvim" /usr/bin/nvim
fi

# First-time setup: symlink this repo as the nvim config dir.
if [[ ! -e "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
  echo "Creating ~/.config/nvim symlink..."
  ln -s "$(pwd)" "$HOME/.config/nvim"
fi
