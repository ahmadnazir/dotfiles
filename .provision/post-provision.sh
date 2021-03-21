#!/bin/bash

# Post install
systemctl enable --now iwd
systemctl enable --now systemd-notify

# TODO: use ansible for yay
yay -S ttf-symbola-free
yay -S silver-searcher-git
yay -S mcrypt
