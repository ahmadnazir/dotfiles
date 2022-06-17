#!/bin/bash

# Post install
systemctl enable --now iwd
systemctl enable --now docker
systemctl enable --now bluetooth

# TODO: don't remember if we need both?
systemctl enable --user --now pulseaudio
systemctl enable --user --now pulseaudio.socket

# I installed ntp and enabled the daemon but the following did the trick. Not
# sure if the previous step was required.
# systemctl status ntpd.service
timedatectl set-ntp true

# Bluetooth
# ---------
sudo rfkill unlock bluetooth

# Add the following to /etc/pulse/system.pa
# ```
# load-module module-bluetooth-policy
# load-module module-bluetooth-discover
# ```
systemctl enable --now bluetooth

# Pair the device
# ```
# - power on
# - discoverable on
# - scan on # wait until the device is found (keep it in pair mode)
# - scan off
# - connect with device
# - trust device # optional
# ```


# TODO: docker groups

# ------------
# User archive
# ------------

# TODO: use ansible for yay

# system level
yay -S ttf-symbola-free
yay -S silver-searcher-git
yay -S mcrypt
yay -S xscreensaver-arch-logo

# other
yay -S nvm

yay -S ngrok

sudo pacman -S gnome-keyring libsecret
