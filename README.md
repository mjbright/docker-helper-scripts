# docker-helper-scripts

Just a few handy docker scripts ...

#### Scripts
- docker_images.sh: Show docker images and their dependent image layers/history
  E.g.
     To list images and their dependent image ids:

       docker_images.sh

     To list images and their dependent image ids/history:

       docker_images.sh -v - lists images and their dependent image ids
   
- watch_pstree.sh: Simple tool to show child processes of the Docker engine.

     Uses watch to update list of processes every 2secs.

     Excludes threads of the Docker engine.

     Shows the processes running within containers.


