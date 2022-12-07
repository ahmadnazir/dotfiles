#!/bin/bash

pkill flameshot
nohup flameshot &
flameshot gui
