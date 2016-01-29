#!/bin/bash

export LANG=C

function reportdb {
    echo "database"
    echo -e " \e[1;31mPlease upgrade database. See instuctions in http://wiki.evolonline.org/guidelines/updating#update_database\e[0m"
}

function reportconf {
    echo "server-data configuration"
    echo -e " \e[1;31mPlease upgrade configuration. See instuctions in http://wiki.evolonline.org/guidelines/updating#update_configuration\e[0m"
}

function dbinfo {
    if [ ! -d "tools" ]; then
        return
    fi
    export VER=$(cat tools/localserver/versions/sqlver 2>/dev/null)

    if [[ -n "${VER}" ]]; then
        if [ "${VER}" -lt "3" ]; then
            reportdb
        fi
        return
    fi
    reportdb
}

function configsinfo {
    if [ ! -d "tools" ]; then
        return
    fi
    export VER=$(cat tools/localserver/versions/confver 2>/dev/null)

    if [[ -n "${VER}" ]]; then
        if [ "${VER}" -lt "1" ]; then
            reportconf
        fi
        return
    fi
    reportconf
}

function status {
    if [ ! -d "$1" ]; then
        return
    fi
    if [ ! -d "$1/.git" ]; then
        echo -e "\e[1;31mError: directory '$1' without git detected. Please remote it and install if need tasks.\e[0m"
        return
    fi
    DIR=$(pwd)
    cd "$1"
    STR=$(git diff --stat --color=always)
    STR2=$(git status|grep -E "Your branch is (behind|ahead)")$(git status|grep -E "have diverged")
    STR3=$(git status -s -uno)
    if [[ "${CMD}" == "commit" || "${CMD}" == "c" ]]; then
        COMMIT=$(git rev-parse HEAD)
        echo -e "$2 ($(git symbolic-ref --short -q HEAD)): \e[1;33m${COMMIT}\e[0m"
    fi
    if [[ -n "${STR}${STR2}${STR3}" ]]; then
        if [[ "${CMD}" != "commit" && "${CMD}" != "c" ]]; then
            echo "$2 ($(git symbolic-ref --short -q HEAD)):"
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
    cd "$DIR"
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
status manaplus manaplus
status docs docs
status art art
status media media
dbinfo
configsinfo
