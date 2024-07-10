#!/usr/bin/env sh

if [ -d /tmp/gamedir ]
then
  echo Deploying custom game files into container...
  rsync -aAX --chown=hlds_user:hlds_user /tmp/gamedir/ /home/hlds_user/hlds/valve/
fi

## Required if you are using hlds_linux, otherwise it will throw this error
## "Error:libsteam_api.so: cannot open shared object file: No such file or directory"
export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"

echo Starting HLDS...
./hlds_run "$@"