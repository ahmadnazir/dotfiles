#!/bin/bash

# @require
# cabal should be installed (packages.sh)
#
# Tempory: symlink so it looks like a program and not a shell script
#          required by haskell-emacs
sudo ln -s ~/.cabal/bin/cabal /usr/bin/cabal


ln -s ~/.bash-scripts/e.sh ~/bin/e
ln -s ~/.bash-scripts/c.sh ~/bin/c
