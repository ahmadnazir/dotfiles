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

# Merlin
alias m='merlin'

# Bash completion
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
bind 'set colored-stats on'        # Colored completion matches
bind 'set colored-completion-prefix on'  # Colored prefix completion
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
