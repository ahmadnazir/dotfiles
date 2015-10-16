# | d . o . t . f . i . l . e . s | 

Along with the dotfiles, this repo also contains my system setup. The
required packages and other requirements should probably go somewhere
else but for the time being this is convenient for me.

## Requirements

This is tested only on Ubuntu 14.04. Following is an incomplete list
of packages required:

### Packages

Install the packages in the packages.sh script

### Installation from source

Emacs is installed from source. I am planning on creating a docker
image that runs the latest version of emacs.. maybe an image already
exists.

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

