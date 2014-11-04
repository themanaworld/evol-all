#!/bin/bash

function status {
    DIR=`pwd`
    cd $1
    STR=`git diff --name-only`
    if [[ -n $STR ]]; then
        echo -e "$2:\e[1;31m"
        echo $STR
        echo -e -n "\e[0m"
    fi
    cd $DIR
}

status . evol-all
status client-data client-data
status server-code server-code
status server-data server-data
status tools tools
status server-code/src/evol evol-hercules
