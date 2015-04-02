#!/bin/bash

function status {
    if [ ! -d "$1" ]; then
        return
    fi
    DIR=$(pwd)
    cd "$1"
    STR=$(git status|grep "Your branch is ahead")
    if [[ -n "${STR}" ]]; then
        echo "Pushing $2"
        git push $CMD
    fi
    cd "$DIR"
}

CMD="$*"
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
status media media
