#!/bin/bash

jekyll () {
	docker run --rm -v "$(pwd):/src" -u `id -u $USER` grahamc/jekyll "$@"
}

jekyll-serve () {
	docker run -d -v "$(pwd):/src" -u `id -u $USER` -p 4000:4000 grahamc/jekyll serve -H 0.0.0.0
}
