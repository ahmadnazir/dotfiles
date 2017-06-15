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
         -w $dir \
         -v `pwd`:$dir \
         -v /ssh-agent:/ssh-agent \
         -v ~/.ssh:/root/.ssh \
         -v $history:/root/.bash_history \
         $image sh -c $cmd

  # -u $UID:$GID \
}
