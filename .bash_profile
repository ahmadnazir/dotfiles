if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi


if [ -d ~/.bash_scripts/ ]; then
    . ~/.bash_scripts/cb
    . ~/.bash_scripts/docker-ip
fi

