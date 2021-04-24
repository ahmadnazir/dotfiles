function scribbles-publish () {
    cd ~/code/me/scribbles
    git push origin `git subtree split --prefix build/html source`:master --force
    cd -
}

function scribbles-clean () {
    cd ~/code/me/scribbles
    rm build -r
    mkdir -p build/html
    touch build/html/.nojekyll
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
