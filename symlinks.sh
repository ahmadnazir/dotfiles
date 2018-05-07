#!/bin/bash

# @require
# cabal should be installed (packages.sh)
#
# Tempory: symlink so it looks like a program and not a shell script
#          required by haskell-emacs
sudo ln -s ~/.cabal/bin/cabal /usr/bin/cabal


# Emacs
#
# Server
ln -s ~/.bash-scripts/init-emacs-daemons.sh ~/bin/init-emacs-daemons

#
# Client
ln -s ~/.bash-scripts/emacs-primary.sh ~/bin/emacs-primary
ln -s ~/.bash-scripts/emacs-secondary.sh ~/bin/emacs-secondary

# Cask
sudo ln -s ~/.cask/bin/cask /usr/bin/cask
