function blog-publish () {
	  cd ~/code/me/ahmadnazir.github.io
	  git push origin `git subtree split --prefix blog/_site source`:master --force
	  cd -
}

function blog-compile () {
	  cd ~/code/me/ahmadnazir.github.io/blog/
	  ./site build
	  cd -
}

function blog-watch () {
	  cd ~/code/me/ahmadnazir.github.io/blog/
	  ./site watch --port 8989
	  cd -
}
