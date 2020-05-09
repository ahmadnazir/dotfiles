#!/bin/bash

sudo apt install ansible

# provision
sudo ansible-playbook playbook.yml -vvv

# Default shell (requires logout)
chsh -s $(which zsh)
