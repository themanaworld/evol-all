#!/bin/bash

CMD="$1"
if [[ -z "${CMD}" ]]; then
    export CMD="default"
fi

if [[ "${CMD}" == "all" || "${CMD}" == "default" ]]; then
    git clone git@gitorious.org:evol/clientdata.git client-data
    git clone git@gitorious.org:evol/hercules.git server-code
    git clone git@gitorious.org:evol/serverdata.git server-data
    git clone git@gitorious.org:evol/evol-tools.git tools
    git clone git@gitorious.org:evol/evol-hercules.git server-code/src/evol
    ln -s server-code/src/evol server-plugin
elif [[ "${CMD}" == "server" ]]; then
    git clone git@gitorious.org:evol/hercules.git server-code
    git clone git@gitorious.org:evol/serverdata.git server-data
    git clone git@gitorious.org:evol/evol-hercules.git server-code/src/evol
    ln -s server-code/src/evol server-plugin
elif [[ "${CMD}" == "client" ]]; then
    git clone git@gitorious.org:evol/clientdata.git client-data
    git clone git@gitorious.org:evol/evol-tools.git tools
elif [[ "${CMD}" == "music" ]]; then
    git clone git@gitorious.org:evol/evol-music.git music
elif [[ "${CMD}" == "bin" ]]; then
    cd server-bin
    ./install.sh
fi

if [[ "${CMD}" == "all" ]]; then
    git clone git@gitorious.org:evol/evol-music.git music
fi
