#!/bin/bash

function status {
    if [ ! -d "$1" ]; then
        return
    fi
    DIR=`pwd`
    cd "$1"
    STR=`git diff --name-only`
    STR2=`git status|grep "Your branch is ahead"`
    if [[ -n "${STR}${STR2}" ]]; then
        echo -e "$2:"
        if [[ -n ${STR} ]]; then
            echo -e "\e[1;31m${STR}"
        fi
        if [[ -n ${STR2} ]]; then
            echo -e "\e[1;32m${STR2}"
        fi
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
status music music
