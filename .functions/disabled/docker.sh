#!/bin/bash
docker-ip() {
    ifconfig | grep docker0 -A1 | tail -1 | grep -E -o '([0-9.]*)' | head -1
}

docker-clean-images() {
    docker images | grep '<none>' | awk '{print $3}' | xargs docker rmi
}

docker-clean-exited-containers() {
    docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm
}

# Sandboxed Docker interactive as sudo
function boxsudi () {

    # image
    if [[ -z $1 ]]; then
        echo "Docker image name not provided";
        return -1;
    fi
    local image=$1;

    local cmd='sh -c /bin/bash'
    # local cmd=sh

    local history=~/.bash_history_docker
    touch $history

    docker run -it \
           -v /ssh-agent:/ssh-agent \
           -v ~/.ssh:/root/.ssh \
           -v $history:/root/.bash_history \
           -w `pwd` \
           -v `pwd`:`pwd` \
           $image $cmd
}

# Run emacs inside a docker container
#
# Still has an issue with the fonts
function demacs () {

  local home=/home/darkman
  docker run -it \
         --rm \
	 -u $UID:$GID \
         -v `pwd`:$home \
	 -e DISPLAY=$DISPLAY \
	 -e NO_AT_BRIDGE=1 \
	 -e HOME=$home \
         -v /tmp/.X11-unix:/tmp/.X11-unix \
         ahmadnazir/emacs:26.2
}

function dport() {
    # image
    if [[ -z $1 ]]; then
        echo "Docker image name not provided";
        return -1;
    fi
    local image=$1;

    # port map
    local map='8080:80'
    if [[ -n $2 ]]; then
        map=$2
    fi

    docker run -p ${map} ${image}
}
