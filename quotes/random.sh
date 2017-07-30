#/bin/bash
shuf -n 1 dictionary.txt | awk -F '|' '{print $1 "\n - " $2}' | cowsay

