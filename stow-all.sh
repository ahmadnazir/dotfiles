#!/bin/bash
set -e
cd "$(dirname "$0")"

for pkg in */; do
  pkg="${pkg%/}"
  stow --restow "$pkg"
  echo "stowed: $pkg"
done
