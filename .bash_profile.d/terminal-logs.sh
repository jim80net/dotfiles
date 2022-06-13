#!/usr/bin/env bash

if [[ "" == "${LOGGING_ENABLED}" ]]
then
    export TIMESTAMP=$(date +%Y-%m-%dT%H:%M%Z)
    script --command "/usr/bin/bash --rcfile /home/jim/.bashrc --init-file /home/jim/.bash_profile.script" --log-out /home/jim/terminal-logs/${TIMESTAMP:?}.log --log-timing /home/jim/terminal-logs/${TIMESTAMP:?}.timing.log --logging advanced
    export LOGGING_TIMESTAMP=$TIMESTAMP
else
    echo "this is the second invocation from /home/jim/.bash_profile.script" > /dev/null
fi

