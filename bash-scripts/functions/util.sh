#!/bin/bash

# http://stackoverflow.com/a/1119738/1589512
function swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# Time

# http://stackoverflow.com/a/12199798/1589512
convertsecs() {
 ((h=${1}/3600))
 ((m=(${1}%3600)/60))
 ((s=${1}%60))
 printf "%02d:%02d:%02d\n" $h $m $s
}

# find process
function fp()
{
    ps ax | grep $1
}

# find process ids
function fpid()
{
    ps ax | grep $1 | awk '{print $1}' 
}

function count-group-by()
{
    if [ -z $1  -o  -z $2 ]; then
        echo "Usage: $0 <column-number> <file> [<delimiter>]";
        return -1;
    fi


    local colNum=$1
    local file=$2
    local delim=${3:-,}

    local cmd="awk -F '"$delim"' 'NR>0{arr[$"$colNum"]++}END{for (a in arr) print a, arr[a]}' "$file
    # echo $cmd
    eval $cmd
}


function get-col()
{
    if [ -z $1 ]; then
        echo "Usage: $0 <column-number> [<delimeter>]";
        return -1;
    fi


    local colNum=$1
    local delim=${2:- }

    local cmd="awk -F '"$delim"' '{print $"$colNum"}' "
    # echo $cmd
    eval $cmd
}

alias c="get-col"

function travis()
{
    local uid=`id -u $USER`
    docker run -it --rm -v "$(pwd):/mounted" -u $uid:$uid mgruener/travis-cli "$@"
}

function preview_()
{
    IN=$1
    OUT=image_%d.png

    # nice /usr/bin/gs -dBATCH -dNOPAUSE -dQUIET \
    #      -dNumRenderingThreads=2 \
    #      -dMaxBitmap=10000000 \
    #      -dGraphicsAlphaBits=4 \
    #      -dTextAlphaBits=4 \
    #      -sDEVICE=png16m \
    #      -r300 \
    #      -dDOINTERPOLATE \
    #      -sOutputFile=$OUT \
    #      -dDownScaleFactor=2 \
    #      -q $IN 

    nice /usr/bin/gs -dBATCH -dNOPAUSE -dQUIET \
         -dNumRenderingThreads=2 \
         -dMaxBitmap=10000000 \
         -dGraphicsAlphaBits=4 \
         -dTextAlphaBits=4 \
         -sDEVICE=png16m \
         -r150 \
         -dDOINTERPOLATE \
         -sOutputFile=$OUT \
         -dDownScaleFactor=2 \
         -q $IN 
}

# function rm()
# {
#     echo "Moved to /tmp/$1"
#     mv $1 /tmp/$1
# }
