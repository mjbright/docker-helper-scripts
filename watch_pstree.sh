#!/bin/bash

# Simple tool to show child processes of the Docker engine.
#   grep is used to remove {thread}'s of the Docker engine.

watch 'pstree -aps 23642 | grep -v "{"'

