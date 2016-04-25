#!/bin/bash

# @require
# cabal should be installed (packages.sh)
#
# Tempory: symlink so it looks like a program and not a shell script
#          required by haskell-emacs
sudo ln -s ~/.cabal/bin/cabal /usr/bin/cabal


# Emacs Daemon
#
# should be used if emacs server is also started. @todo: how to start
# the server from the shell?
ln -s ~/.bash-scripts/edmn.sh ~/bin/edmn
#
# Emacs client
ln -s ~/.bash-scripts/c.sh ~/bin/c
#
# Emacs
#
# should be used if emacs server isn't being used
ln -s ~/.bash-scripts/e.sh ~/bin/e
