#!/bin/bash

# Spotify
sudo snap install spotify

# Clojure
cd /tmp
curl -O https://download.clojure.org/install/linux-install-1.10.1.536.sh
chmod +x linux-install-1.10.1.536.sh
sudo ./linux-install-1.10.1.536.sh
