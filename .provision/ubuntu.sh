#!/bin/bash

# Spotify
sudo snap install spotify

# Clojure
cd /tmp
curl -O https://download.clojure.org/install/linux-install-1.10.1.536.sh
chmod +x linux-install-1.10.1.536.sh
sudo ./linux-install-1.10.1.536.sh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# source code pro fonts
# Check out instructions here: https://askubuntu.com/a/437183/373495

# jdk

# https://www.azul.com/downloads/azure-only/zulu/?version=java-8-lts&os=ubuntu&architecture=x86-64-bit&package=jdk
# or use intellij to download it
