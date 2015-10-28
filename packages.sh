# Use zsh
# @todo: remove this as oh-my-zsh will take care of it
chsh -s /bin/zsh

# oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo 'Link the zshrc file in ahmadnazir/dotfiles manually';

sudo apt-get install \
 zsh \
 lxc-docker-1.7.1 \
 ;

# Install 'docker compose'
# @see: https://docs.docker.com/compose/install/
sudo -i
curl -L https://github.com/docker/compose/releases/download/1.3.3/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
exit

# Really fast search: ag > awk > grep (Runtimes)
# @see https://github.com/ggreer/the_silver_searcher
apt-get install silversearcher-ag

# The following should preferebly? use docker containers

# Cabal
#
# Install cli tool for cabal
# Once installed, the cli tool is called cabal and not cabal-install
sudo apt-get install cabal-install
#
# Install the latest version of the tool using iteself
cabal install cabal-install
#
# Remove the older version of cabal
sudo apt-get remove cabal-install
#
# Tempory: symlink so it looks like a program and not a shell script
#          required by haskell-emacs
sudo ln -s /home/mandark/.cabal/bin/cabal cabal

# Haskell
# @todo: Other requirements need to be added as well
# @see: https://github.com/serras/emacs-haskell-tutorial/blob/master/tutorial.md#haskell-mode
#
# Indentation
cabal install happy
cabal install structured-haskell-mode # emacs package required 'exec-path-from-shell'


# Autojump
sudo apt-get install autojump

# Other repositories for getting the latest versions e.g. git
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

# Misc
apt-get install libpam-google-authenticator

# Git
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
