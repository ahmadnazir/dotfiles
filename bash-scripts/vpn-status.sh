#!/bin/bash

# function vpn-status()
# {
#     ifconfig tun0 > /dev/null &&
#         if [[ $? == 0 ]]
#         then
#             echo -e " :)"
#         fi ||
#             echo -e ":'("
# }

function vpn-status()
{
    if [[ $(routel | grep tun0) ]]; then
        echo -e "✔"
    else
        echo -e "✖"
    fi
}

vpn-status
