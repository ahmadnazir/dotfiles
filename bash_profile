#!/bin/bash

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi
if [ -d "$HOME/.cask/bin" ] ; then
  PATH="$PATH:$HOME/.cask/bin"
fi
if [ -d "$HOME/packer" ] ; then
  PATH="$PATH:$HOME/packer"
fi

# Load all the functions
for file in ~/.bash-scripts/functions/*.sh
do
  . $file
done

