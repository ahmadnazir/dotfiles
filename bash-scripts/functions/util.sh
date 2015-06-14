#!/bin/bash

# http://stackoverflow.com/a/1119738/1589512
function swap()         
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}
