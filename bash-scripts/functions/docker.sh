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

# Get an interactive docker environment mapped to the current working directory
#
# Usage: 'di haskell', which will run a container for the haskell image
di () {
	if [ -z "$1" ]; then
		echo "Docker image name not provided";
		return -1;
	fi
	local dir='/shared'
	docker run -it --rm -w $dir -v `pwd`:$dir $1
}
