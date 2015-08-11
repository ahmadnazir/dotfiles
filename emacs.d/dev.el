;; PHP unit
(load-file "~/code/forks/nlamirault/phpunit.el/phpunit.el")
;;
;; Helpers
;;
(defun an-phpunit-get-program ()
  "Return the docker command to launch unit test"
  (progn ()
		 (if (get-buffer "**phpunit-docker**") (kill-buffer "**phpunit-docker**"))
		 ;; @hack: there can be multiple containers running for the same image
		 ;; Get the container id
		 (call-process-shell-command "docker ps | grep 'penneo/webapp' | awk '{printf $1}'" nil "**phpunit-docker**")
		 (s-concat "docker exec " (an-buffer-string "**phpunit-docker**") " phpunit")
		 )
  )
;;
;; Overrides
;;
(defun phpunit-get-program (args)
  "Return the command to launch unit test.
`ARGS' corresponds to phpunit command line arguments."
  ;; (s-concat phpunit-program " -c "
  (s-concat (an-phpunit-get-program) " -c "
	    (phpunit-get-root-directory)
	    phpunit-configuration-file
	    args))



;; Rest Client
(load-file "~/code/forks/pashky/restclient.el/restclient.el")

;; Extend Emacs with Haskell
(load-file "~/code/forks/knupfer/haskell-emacs/haskell-emacs.el")
(require 'haskell-emacs)
;; (haskell-emacs-init) ;; required for compiling. Better use it interactively
