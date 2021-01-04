#!/bin/bash

sudo apt install ansible

# provision
sudo ansible-playbook common.yml -vvv
sudo ansible-playbook linux.yml -vvv

# Default shell (requires logout)
chsh -s $(which zsh)

# Docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker # This only works for current shell / Restart to make sure groups are re-evaluated

# source code pro fonts
# Check out instructions here: https://askubuntu.com/a/437183/373495

# jdk

# https://www.azul.com/downloads/azure-only/zulu/?version=java-8-lts&os=ubuntu&architecture=x86-64-bit&package=jdk
# or use intellij to download it


