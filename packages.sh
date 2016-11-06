#!/bin/bash

# Use zsh
# #zsh
# @todo: remove this as oh-my-zsh will take care of it
chsh -s /bin/zsh

# oh-my-zsh
#
# @todo: this is probably not required anymore since we ca set it up using athame zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo 'Link the zshrc file in ahmadnazir/dotfiles manually';

sudo apt-get install zsh # How can I install this when the initial commands depend on it? #zsh
sudo apt-get install lxc-docker-1.7.1

# Install 'docker compose'
# @see: https://docs.docker.com/compose/install/
sudo -i
curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Really fast search: ag > awk > grep (Runtimes)
# @see https://github.com/ggreer/the_silver_searcher
apt-get install silversearcher-ag

# The following should preferably? use docker containers

##########
# Haskell
##########
#
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
# @todo: Other requirements need to be added as well
# @see: https://github.com/serras/emacs-haskell-tutorial/blob/master/tutorial.md#haskell-mode
#
# Indentation
cabal install happy
cabal install structured-haskell-mode # emacs package required 'exec-path-from-shell'
#
# Stack
curl -sSL https://get.haskellstack.org/ | sh

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
sudo apt-get install gitk

# NPM packages
sudo apt-get install npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
#
# eslint
# sudo npm install -g eslint@0.24.1 # update this later. 1.7 didn't show line numbers
# sudo npm install -g eslint@1.8.0
sudo npm install -g eslint-plugin-react@2.6.4
# sudo npm install -g eslint@1.8.0
sudo npm install -g eslint eslint-config-standard eslint-plugin-standard eslint-plugin-promise
sudo npm install -f babel-eslint # not installed yet..

# Symfony installer
sudo curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony
sudo chmod a+x /usr/local/bin/symfony

# Pdf editing
sudo apt-get install xournal

# AWS CLI
pip install awscli

# elm
sudo npm install -g elm
sudo npm install -g elm-reactor # browser interfact and autocompile
sudo npm install -g elm-oracle # documentation
sudo npm install -g elm-live # live reloading : doesn't seem to be working

# Network related
sudo apt-get install bmon # maybe also consider tcptrack?

sudo apt-get install openvpn
sudo apt-get install openjdk-7-jdk

# Virtual box
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" > /etc/apt/sources.list.d/virtualbox.list'
sudo apt-get update
sudo apt-get install virtualbox-5.0 dkms
#
# Extension pack (for ievms)
sudo apt-get install unar
sudo VBoxManage extpack install ~/Downloads/Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack # Requires that the pack is downloaded

sudo apt-get install git-svn

# Silver light on ubuntu
sudo add-apt-repository ppa:pipelight/stable
# sudo apt-get update && sudo apt-get install pipelight-multi
# sudo pipelight-plugin --enable silverlight


# mpeg4 aac decoder plugin for totem
sudo apt-get install ubuntu-restricted-extras

# xmind
sudo apt-get install lame
sudo dpkg -i xmind-7.5-update1-linux_amd64.deb


# vim
git clone https://github.com/vim/vim
cd vim
./configure --with-features=huge
make
sudo make install
# athame with xsh
#
# This patches zsh with athame
git clone --recursive http://github.com/ardagnir/athame
cd athame
sudo apt-get build-dep zsh
CPPFLAGS="-std=c99" ./zsh_athame_setup.sh --vimbin=/usr/local/bin/vim

# adobe source code pro
#
# @see: https://github.com/adobe-fonts/source-code-pro 
npm install git://github.com/adobe-fonts/source-code-pro.git#release

# 
