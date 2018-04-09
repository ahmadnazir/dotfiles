#!/bin/bash

cd ~/Documents/journal/
ls -ltra | c 9 | grep '^201.*[^~]$' | xargs -I % grep 'Total time' % | c 3 '|' | c 1 | c 2 '*' | c 1 ':' | plot -w 200
cd -
