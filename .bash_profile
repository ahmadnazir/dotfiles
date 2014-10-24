if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi


if [ -f ~/.bash_scripts/cb ]; then
    . ~/.bash_scripts/cb
fi

