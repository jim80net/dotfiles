#!/usr/bin/env bash

if [[ "" == "${LOGGING_ENABLED}" ]]
then
    export TIMESTAMP=$(date +%Y-%m-%dT%H:%M%Z)
    script --command "/usr/bin/bash --rcfile ${HOME}/.bashrc --init-file ${HOME}/.bash_profile.script" --log-out ${HOME}/terminal-logs/${TIMESTAMP:?}.log --log-timing ${HOME}/terminal-logs/${TIMESTAMP:?}.timing.log --logging advanced
    export LOGGING_TIMESTAMP=$TIMESTAMP
else
    echo "this is the second invocation from ${HOME}.bash_profile.script" > /dev/null
fi

