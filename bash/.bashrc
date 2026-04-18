# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

export PATH="$HOME/.local/bin:$PATH"
alias l='looney'

export NVM_DIR="$HOME/.nvm"

nvm() {
    unset -f nvm
    source /usr/share/nvm/init-nvm.sh
    nvm "$@"
}

# eval "$(mise activate bash)"

. "$HOME/.local/share/../bin/env"

if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto --sort=modified'
  alias lsa='ls -a'
  alias lsar='lsa --reverse'
  alias lt='eza --tree --level=2 --long --icons --git --sort=modified'
  alias lta='lt -a'
  alias ltar='lta --reverse'
fi


alias lg='lazygit'
