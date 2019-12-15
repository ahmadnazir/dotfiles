#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $DIR

shuf -n 1 dictionary.txt | awk -F '|' '{print $1 "\n - " $2}' | cowsay

