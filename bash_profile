#!/bin/bash

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi
if [ -d "$HOME/.cask/bin" ] ; then
  PATH="$PATH:$HOME/.cask/bin"
fi


if [ -d ~/.bash-scripts/ ]; then
    . ~/.bash-scripts/cb.sh
    . ~/.bash-scripts/docker.sh
    . ~/.bash-scripts/visual.sh
    . ~/.bash-scripts/system.sh
    # . ~/.bash-scripts/wireless.sh
fi
