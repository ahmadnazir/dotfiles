#!/bin/bash

cd "$(dirname "$(realpath "$0")")"

sudo ansible-playbook common.yml -vvv
sudo ansible-playbook linux.yml -vvv


