#!/bin/bash

function status {
    if [ ! -d "$1" ]; then
        return
    fi
    DIR=$(pwd)
    cd "$1"
    echo "$2:"
    URL=$(git config remote.origin.url|sed "s/gitorious.org/gitlab.com/")
    git config remote.origin.url ${URL}
    echo "set origin to ${URL}"
    cd "$DIR"
}

CMD="$1"

if [[ "${CMD}" != "gitlab" ]]; then
    exit 1
fi

status . evol-all
status client-data client-data
status server-code server-code
status server-data server-data
status server-local server-local
status tools tools
status server-code/src/evol evol-hercules
status music music
status manaplus manaplus
status media media
