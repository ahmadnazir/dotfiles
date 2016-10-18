#!/bin/bash

function vpn-status()
{
    ifconfig tun0 > /dev/null &&
        if [[ $? == 0 ]]
        then
            echo -e " :)"
        fi ||
            echo -e ":'("
}

vpn-status
