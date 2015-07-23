# | d . o . t . f . i . l . e . s | 

## Requirements

This is tested only on Ubuntu 14.04. Following is an incomplete list of packages required:

### Packages
```
sudo apt-get install \
 zsh \
 lxc-docker-1.7.1 \
 
```

### Installation from source

Emacs is installed from source

## Setup

An install script is missing. Until then, here is an incomplete list of scripts to setup the system:

```
# Use zsh
# @todo: remove this as oh-my-zsh will take care of it
chsh -s /bin/zsh

# oh-my-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo 'Link the zshrc file in ahmadnazir/dotfiles manually';
```

## Todo:

### Emacs

#### Shell
- Open shells easily. I lost this functionality because the file wasn't under version control.
  Refer to [Super user question: Directly open remote shell with tramp in emacs](http://superuser.com/a/905060/413325)
- Interaction with docker containers

##### Window Commands
- On saving, go in vi 'normal mode'

##### Package Management
- Keep a list of packages that the emacs configurations depend on

### Misc
- A script is required that creates symlinks in the home folder for all the files/folders present in the top level of this repo. As an example, see [Using Git And Github To Manage Your Dotfiles](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/)

