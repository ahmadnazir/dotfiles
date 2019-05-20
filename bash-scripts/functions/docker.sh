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

# Docker interactive as sudo
function sudi () {

  # image
  if [[ -z $1 ]]; then
    echo "Docker image name not provided";
    return -1;
  fi
  local image=$1;

  local cmd='/bin/bash'

  local history=~/.bash_history_docker
  touch $history

  docker run -it \
         -v /ssh-agent:/ssh-agent \
         -v ~/.ssh:/root/.ssh \
         -v $history:/root/.bash_history \
         -v /etc/passwd:/etc/passwd \
         -v /etc/group:/etc/group \
         -v $HOME:$HOME \
         -w `pwd` \
         -v `pwd`:`pwd` \
         $image sh -c $cmd
}

# Docker interactive: Get an interactive docker environment mapped to
# the current working directory
#
# Usage: 'di haskell', which will run a container for the haskell image
function di () {

  # image
  if [[ -z $1 ]]; then
    echo "Docker image name not provided";
    return -1;
  fi
  local image=$1;

  # shared directory
  local dir='/app/data';

  # Either open an interactive shell for the image or run the command
  #
  # @todo: If not command is specified, docker is being invoked as:
  #
  # docker run -it IMAGE sh -c /bin/bash
  #
  # so like using a shell to run a shell which doesn't make sense. I need to
  # investigate how to fix it and still be able to pass the arguments
  local cmd='/bin/bash'
  if [[ -n $2 ]]; then
      cmd="${@:2}"
  fi

  local history=~/.bash_history_docker
  touch $history

  docker run -it \
         --rm \
         -v /ssh-agent:/ssh-agent \
         -v ~/.ssh:/root/.ssh \
         -v $history:/root/.bash_history \
         -v /etc/passwd:/etc/passwd \
         -v /etc/group:/etc/group \
         -v $HOME:$HOME \
         -w `pwd` \
         -v `pwd`:$dir \
         -u $UID:$GID \
         $image sh -c $cmd

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
