# | d . o . t . f . i . l . e . s | 

Along with the dotfiles, this repo also contains my system setup. The
required packages and other requirements should probably go somewhere
else but for the time being this is convenient for me.

## Requirements

This is tested only on Ubuntu 14.04. Following is an incomplete list
of packages required:

### Packages
```
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
```

### Installation from source

Emacs is installed from source. I am planning on creating a docker
image that runs the latest version of emacs.. maybe an image already
exists.

## Setup

An install script is missing. Until then, here is an incomplete list
of scripts to setup the system:

```
# Use zsh
# @todo: remove this as oh-my-zsh will take care of it
chsh -s /bin/zsh

# oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo 'Link the zshrc file in ahmadnazir/dotfiles manually';
```

## Todo

### Emacs

#### Use Docker image
- Use a docker image to run the latest version of emacs

#### Shell
- Open shells easily. I lost this functionality because the file
  wasn't under version control.  Refer to
  [Super user question: Directly open remote shell with tramp in emacs](http://superuser.com/a/905060/413325)
- Interaction with docker containers

##### Window Commands
- On saving, go in vi 'normal mode'

##### Package Management
- Keep a list of packages that the emacs configurations depend on

### Misc
- A script is required that creates symlinks in the home folder for
  all the files/folders present in the top level of this repo. As an
  example, see
  [Using Git And Github To Manage Your Dotfiles](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/)

