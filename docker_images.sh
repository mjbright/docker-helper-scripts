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

# Declare image_seen as an associative array:
declare -A image_seen

# Obtain docker images:
for image_id in $(docker images | tail -n+2 | awk '{print $3;}'); do

    # Make KEY alphanumeric (avoid 1st char numeric, which causes bash to treat as a number)
    #    to avoid: 'value too great for base' error message
    KEY=I_$image_id

    #echo ${seen[$KEY]}
    if [ "${seen[$KEY]}" != "" ];then
        seen[$KEY]=SEEN
        #echo "seen[$KEY]=SEEN"
    fi
    
    # For each docker image obtain dependent image-layers using history command:
    echo "---- IMAGE: $image_id $(docker images | grep $image_id | sed 's/  */ /g')"
    [ $VERBOSE -eq 0 ] &&
        docker history $image_id | tail -n+2 | awk '{print $1;}' | sed 's/^/    /' ||
        docker history $image_id | tail -n+2 | \
            sed -e 's/      //' -e 's/^/    /' -e 's/ *$//'
done

