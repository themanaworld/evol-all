#!/bin/bash

export LANG=C

CMD="$1"
PROTO="git@gitlab.com:"
if [[ -z "${CMD}" ]]; then
    export CMD="default"
fi

STR=$(git remote -v|grep "https://")
if [[ -n "${STR}" ]]; then
    export PROTO="https://gitlab.com/"
fi

if [[ "${CMD}" == "all" || "${CMD}" == "default" ]]; then
    git clone ${PROTO}evol/clientdata.git client-data
    git clone ${PROTO}evol/hercules.git server-code
    git clone ${PROTO}evol/serverdata.git server-data
    git clone ${PROTO}evol/evol-tools.git tools
    git clone ${PROTO}evol/evol-hercules.git server-code/src/evol
    git clone ${PROTO}evol/evol-local.git server-local
    git clone ${PROTO}evol/evol-docs.git docs
    ln -s server-code/src/evol server-plugin
elif [[ "${CMD}" == "server" ]]; then
    git clone ${PROTO}evol/hercules.git server-code
    git clone ${PROTO}evol/serverdata.git server-data
    git clone ${PROTO}evol/evol-hercules.git server-code/src/evol
    git clone ${PROTO}evol/evol-tools.git tools
    ln -s server-code/src/evol server-plugin
elif [[ "${CMD}" == "client" ]]; then
    git clone ${PROTO}evol/clientdata.git client-data
    git clone ${PROTO}evol/evol-tools.git tools
elif [[ "${CMD}" == "music" ]]; then
    git clone ${PROTO}evol/evol-music.git music
elif [[ "${CMD}" == "local" ]]; then
    git clone ${PROTO}evol/evol-local.git server-local
    git clone ${PROTO}evol/hercules.git server-code
    git clone ${PROTO}evol/serverdata.git server-data
    git clone ${PROTO}evol/evol-hercules.git server-code/src/evol
    git clone ${PROTO}evol/evol-tools.git tools
    ln -s server-code/src/evol server-plugin
elif [[ "${CMD}" == "tools" ]]; then
    git clone ${PROTO}evol/evol-tools.git tools
elif [[ "${CMD}" == "docs" ]]; then
    git clone ${PROTO}evol/evol-docs.git docs
elif [[ "${CMD}" == "manaplus" ]]; then
    git clone ${PROTO}manaplus/manaplus.git manaplus
elif [[ "${CMD}" == "media" ]]; then
    git clone ${PROTO}evol/evol-media.git media
fi

if [[ "${CMD}" == "all" ]]; then
    git clone ${PROTO}evol/evol-music.git music
    git clone ${PROTO}manaplus/manaplus.git manaplus
    git clone ${PROTO}evol/evol-media.git media
fi
