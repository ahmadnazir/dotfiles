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
