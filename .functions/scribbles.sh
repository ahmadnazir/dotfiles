function scribbles-publish () {
    cd ~/code/me/scribbles
    git push origin `git subtree split --prefix build/html source`:master --force
    cd -
}

function scribbles-clean () {
    cd ~/code/me/scribbles/build
    mv html html_
    mkdir html
    touch html/.nojekyll
    rm html_ -r
    scribbles-compile
    cd -
}

function scribbles-compile () {
    cd ~/code/me/scribbles
    docker run -it --rm \
           -v /etc/passwd:/etc/passwd \
           -v /etc/group:/etc/group \
           -v $HOME:$HOME \
           -w `pwd` -v `pwd`:`pwd` \
           -u $UID:$GID \
           ahmadnazir/sphinx make html
    cd -
}

function scribbles-clean-compile () {
    scribbles-clean
    scribbles-compile
}
