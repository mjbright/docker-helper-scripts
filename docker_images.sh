#!/bin/bash

# Description: script to list docker images on a system, showing image-layers
#              used by each "image".
#
#              With -v option shows history of each image also
#
# Usage:
#     docker_images.sh    : list images and dependent image-layers
#     docker_images.sh -v : list images and dependent image-layers/history
#

VERBOSE=0
[ "$1" = "-v" ] && VERBOSE=1

# Obtain docker images:
for image_id in $(docker images | tail -n+2 | awk '{print $3;}'); do
    
    # For each docker image obtain dependent image-layers using history command:
    echo "---- IMAGE: $image_id $(docker images | grep $image_id | sed 's/  */ /g')"
    [ $VERBOSE -eq 0 ] &&
        docker history $image_id | tail -n+2 | awk '{print $1;}' | sed 's/^/    /' ||
        docker history $image_id | tail -n+2 | \
            sed -e 's/      //' -e 's/^/    /' -e 's/ *$//'
done

