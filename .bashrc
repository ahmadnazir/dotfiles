#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Ctrl-a doesn't always work with colors enabled
# PS1="\e[0;32m[\t] \w > \e[m "
PS1='[\t] \w $ '

print_pre_prompt ()
{
    #  NX Version
    NX_VER=`nx --version`
    status=$?
    if [ $status -eq 0 ]; then
        PS1R="nx: ${NX_VER} |"
    fi

    #  Node Version
    PS1R="${PS1R} node: `node -v`"

    PS1L=''
    printf "%s%$(($COLUMNS-${#PS1L}))s" "$PS1L" "$PS1R"
    PS1R=''
}
PROMPT_COMMAND=print_pre_prompt

# kitty
source <(kitty + complete setup bash)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. /usr/share/autojump/autojump.bash

export PATH=$PATH:~/.local/bin/
# Custom functions
for file in ~/.functions/*.sh
do
    . $file
done

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
