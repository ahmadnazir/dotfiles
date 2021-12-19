#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# kitty
source <(kitty + complete setup bash)

# NVM
[ -z "" ] && export NVM_DIR="/home/mandark/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

. /usr/share/autojump/autojump.bash

# Custom functions
for file in ~/.functions/*.sh
do
    . $file
done

