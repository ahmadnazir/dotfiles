# IMAGE=ahmadnazir/sphinx
IMAGE=suttang/sphinx-rtd-theme
DIR=~/code/me/scribbles

function -scribbles-publish () {
    cd $DIR > /dev/null

    text-info 'SCRIBBLES :: Publishing to https://ahmadnazir.github.io/scribbles'

    git push origin `git subtree split --prefix build/html source`:master --force

    text-info 'SCRIBBLES :: Publishing man pages'

    sudo cp build/man/scribbles.7 /usr/share/man/man7/
    cd - > /dev/null
}

function -scribbles-clean () {
    cd $DIR/build > /dev/null
    mv html html_
    mkdir html
    touch html/.nojekyll
    rm html_ -r
    cd - > /dev/null
}

function -scribbles-compile () {
    docker run -it --rm \
           -v /etc/passwd:/etc/passwd \
           -v /etc/group:/etc/group \
           -v $HOME:$HOME \
           -w $DIR -v $DIR:$DIR \
           -u $UID:$GID \
           $IMAGE make html man
}

function scribbles-publish () {
    # Can publish?
    cd $DIR > /dev/null
    git status | grep 'working tree clean'
    RESULT=$?
    if [ $RESULT -ne 0 ]; then

        text-error 'SCRIBBLES :: Content cannot be published until changes are committed.'

        git diff
    else
        -scribbles-clean
        -scribbles-compile
        -scribbles-publish
    fi
    cd - > /dev/null
}
