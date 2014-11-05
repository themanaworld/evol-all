#!/bin/bash

function status {
    DIR=`pwd`
    cd $1
    STR=`git status|grep "Your branch is ahead"`
    if [[ -n ${STR} ]]; then
        echo "pusing $1"
        git push
    fi
    cd $DIR
}

status . evol-all
status client-data client-data
status server-code server-code
status server-data server-data
status tools tools
status server-code/src/evol evol-hercules
