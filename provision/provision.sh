#!/bin/bash

sudo apt install ansible

# provision
sudo ansible-playbook playbook.yml -vvv

# Default shell (requires logout)
chsh -s $(which zsh)

# Docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker # This only works for current shell / Restart to make sure groups are re-evaluated
