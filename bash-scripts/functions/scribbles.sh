function scribbles-publish () {
    cd ~/code/me/scribbles
    git push origin `git subtree split --prefix build/html source`:master --force
    cd -
}

function scribbles-clean () {
    cd ~/code/me/scribbles
    cd build
    mv html html_
    mkdir html
    touch html/.nojekyll
    rm html_ -r
    cd -
}

function scribbles-compile () {
    cd ~/code/me/scribbles
    di ahmadnazir/sphinx make html
    cd -
}

function scribbles-clean-compile () {
    scribbles-clean
    scribbles-compile
}
