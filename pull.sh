#!/usr/bin/env bash

export LANG=C

function status {
    if [ ! -d "$1" ]; then
        return
    fi
    DIR=$(pwd)
    cd "$1"
    echo "$2 ($(git symbolic-ref --short -q HEAD)):"
    if [[ "${CMD}" == "force" ]]; then
        git pull --commit --no-edit
        cd "$DIR"
        return
    fi
    STR=$(git diff --name-only)
    STR2=$(git status|grep "Your branch is ahead")$(git status|grep -E "have diverged")
    STR3=$(git status -s -uno)
    if [[ -n "${STR}${STR2}${STR3}" ]]; then
        echo -e "\e[1;31mCant pull because changes not pushed\e[0m"
    else
        git pull
    fi
    cd "$DIR"
}

function status2 {
    if [ ! -d "$1" ]; then
        return
    fi
    DIR=$(pwd)
    cd "$1"
    STR=$(git diff --name-only)
    STR2=$(git status|grep "Your branch is ahead")
    STR3=$(git status -s -uno)
    echo "$2 ($(git symbolic-ref --short -q HEAD)):"
    if [[ -n "${STR}${STR2}${STR3}" ]]; then
        echo -e "\e[1;31mCant pull because changes not pushed\e[0m"
    else
        git fetch upstream
        git fetch origin
        git reset --hard "$(git rev-parse --abbrev-ref --symbolic-full-name @{u})"
    fi
    cd "$DIR"
}

CMD="$1"
if [[ -z "${CMD}" ]]; then
    export CMD="normal"
fi

status . evol-all
status client-data client-data
status2 server-code server-code
status server-data server-data
status server-local server-local
status tools tools
status server-code/src/evol evol-hercules
status music music
status manaplus manaplus
status docs docs
status art art
status media media
