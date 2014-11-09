#!/bin/bash

function status {
    if [ ! -d "$1" ]; then
        return
    fi
    DIR=`pwd`
    cd "$1"
    STR=`git diff --name-only`
    STR2=`git status|grep "Your branch is ahead"`
    STR3=`git status -s -uno`
    echo "$2:"
    if [[ -n "${STR}${STR2}${STR3}" ]]; then
        echo -e "\e[1;31mCant pull because changes not pushed\e[0m"
    else
        git pull
    fi
    cd $DIR
}

status . evol-all
status client-data client-data
status server-code server-code
status server-data server-data
status tools tools
status server-code/src/evol evol-hercules
status music music
status art art
