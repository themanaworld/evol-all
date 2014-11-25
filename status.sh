#!/bin/bash

function status {
    if [ ! -d "$1" ]; then
        return
    fi
    DIR=`pwd`
    cd "$1"
    STR=`git diff --stat --color=always`
    STR2=`git status|grep -E "Your branch is (behind|ahead)"`
    STR3=`git status -s -uno`
    if [[ "${CMD}" == "commit" || "${CMD}" == "c" ]]; then
        COMMIT=`git rev-parse HEAD`
        echo -e "$2: \e[1;33m${COMMIT}\e[0m"
    fi
    if [[ -n "${STR}${STR2}${STR3}" ]]; then
        if [[ "${CMD}" != "commit" && "${CMD}" != "c" ]]; then
            echo "$2:"
        fi
        if [[ -n ${STR2} ]]; then
            echo -e "\e[1;32m${STR2}\e[0m"
        fi
        if [[ -n ${STR} ]]; then
            echo "${STR}"
        elif [[ -n ${STR3} ]]; then
            echo -e "\e[1;33m${STR3}\e[0m"
        fi
    fi
    cd $DIR
}

CMD="$1"
if [[ -z "${CMD}" ]]; then
    export CMD="default"
fi

status . evol-all
status client-data client-data
status server-code server-code
status server-data server-data
status server-local server-local
status tools tools
status server-code/src/evol evol-hercules
status music music
status art art
status manaplus manaplus
