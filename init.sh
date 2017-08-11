#!/usr/bin/env bash

export LANG=C
export GROUP=evol

CMD="$1"
PROTO="git@gitlab.com:"
if [[ -z "${CMD}" ]]; then
    export CMD="default"
fi

STR=$(git remote -v|grep "https://")
if [[ -n "${STR}" ]]; then
    export PROTO="https://gitlab.com/"
fi

CLONECMD="git clone --origin upstream"
CLONE1="${CLONECMD} ${PROTO}${GROUP}"
CLONE2="${CLONECMD} ${PROTO}"

if [[ "${CMD}" == "all" || "${CMD}" == "default" ]]; then
    ${CLONE1}/clientdata.git client-data
    ${CLONE1}/hercules.git server-code
    ${CLONE1}/serverdata.git server-data
    ${CLONE1}/evol-tools.git tools
    ${CLONE1}/evol-hercules.git server-code/src/evol
    ${CLONE1}/evol-local.git server-local
    ${CLONE1}/evol-docs.git docs
    ln -s server-code/src/evol server-plugin
elif [[ "${CMD}" == "server" ]]; then
    ${CLONE1}/hercules.git server-code
    ${CLONE1}/serverdata.git server-data
    ${CLONE1}/evol-hercules.git server-code/src/evol
    ${CLONE1}/evol-tools.git tools
    ln -s server-code/src/evol server-plugin
elif [[ "${CMD}" == "client" ]]; then
    ${CLONE1}/clientdata.git client-data
    ${CLONE1}/evol-tools.git tools
elif [[ "${CMD}" == "music" ]]; then
    ${CLONE1}/evol-music.git music
elif [[ "${CMD}" == "local" ]]; then
    ${CLONE1}/evol-local.git server-local
    ${CLONE1}/hercules.git server-code
    ${CLONE1}/serverdata.git server-data
    ${CLONE1}/evol-hercules.git server-code/src/evol
    ${CLONE1}/evol-tools.git tools
    ln -s server-code/src/evol server-plugin
elif [[ "${CMD}" == "tools" ]]; then
    ${CLONE1}/evol-tools.git tools
elif [[ "${CMD}" == "docs" ]]; then
    ${CLONE1}/evol-docs.git docs
elif [[ "${CMD}" == "manaplus" ]]; then
    ${CLONE2}manaplus/manaplus.git manaplus
elif [[ "${CMD}" == "media" ]]; then
    ${CLONE1}/evol-media.git media
fi

if [[ "${CMD}" == "all" ]]; then
    ${CLONE1}/evol-music.git music
    ${CLONE2}manaplus/manaplus.git manaplus
    ${CLONE1}/evol-media.git media
fi
