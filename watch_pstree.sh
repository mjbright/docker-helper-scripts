#!/bin/bash

# Simple tool to show child processes of the Docker engine.
#   grep is used to remove {thread}'s of the Docker engine.

die() {
    echo "$0: die - $*" >&2
    exit 1
}

if [ -z "$1" ];then
    # Get Docker engine PID:
    PID=$(ps -fade | awk '/docker.*daemon/ && !/grep/ {print $2;}')
else
    #set -x
    case $1 in
        [0-9]*) PID=$1;;
        *)      PID=$(ps -fade | awk "/$1/ && !/grep/ {print \$2; exit(0); }");;
    esac
fi

[ -z "$PID" ] && die "Failed to obtain PID for <$1>"
#exit 0

watch "pstree -aps $PID | grep -v '{'"

