#!/bin/bash

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi


if [ -d ~/.bash-scripts/ ]; then
    . ~/.bash-scripts/cb
    . ~/.bash-scripts/docker-ip
fi

