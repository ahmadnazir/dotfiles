function scribbles-publish () {
    cd ~/code/me/scribbles
    git push origin `git subtree split --prefix build/html source`:master --force
    cd -
}

function scribbles-compile () {
    cd ~/code/me/scribbles
    di ahmadnazir/sphinx make html
    cd -
}

