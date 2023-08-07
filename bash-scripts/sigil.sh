#!/bin/bash

lpass show 1473164222391291692 --json | jq .[0].password -r | xclip -selection c
dunstify "Copied to clipboard"
