#!/bin/bash

# Requires ansible

# provision
ansible-galaxy install kewlfft.aur
sudo ansible-playbook common.yml -vvv
sudo ansible-playbook linux.yml -vvv


# # Default shell (requires logout)
# chsh -s $(which zsh)

# # Docker
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker # This only works for current shell / Restart to make sure groups are re-evaluated



