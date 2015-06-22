;; Connecting to remote machines
(defun anr-connect-to-machine_ (target dir)
  (progn
	(let ((path (concat target dir)))
	  (dired path)
	  ))
  )

;; @todo: the following 'connect to' functions should be replaced by
;; variables that should be passed to the
;; anr-connect-to-machine_ function
;; ------------------------- start --------------------------------

(defun anr-connect-to-local ()
  (interactive)
  (anr-connect-to-machine_ "" "/home/mandark/code/"))

(defun anr-connect-to-penneo-dev ()
  (interactive)
  (anr-connect-to-machine_ "/mandark@ar-dev.penneo.com:" "/home/mandark/code/"))

(defun anr-connect-to-penneo-live ()
  (interactive)
  (anr-connect-to-machine_ "/ahmadnazir@app.penneo.com:" "/var/www/"))

(defun anr-connect-to-docker-2222 ()
  (interactive)
  (anr-connect-to-machine_ "/vagrant@localhost#2222:" "/vagrant/"))

(defun anr-connect-to-docker-2200 ()
  (interactive)
  (anr-connect-to-machine_ "/vagrant@localhost#2200:" "/vagrant/"))

;; -------------------------- end ---------------------------------

;; Connect to the docker instance and give me a shell
(defun anr-shell-view ()
  (interactive)
  (progn
	(delete-other-windows)
	(split-window-right)
	(other-window 1)
	(anr-connect-to-machine)
	(shell)
	))

;; Todo View
(defun anr-todo-view ()
  (interactive)
  (progn
	(delete-other-windows)
	(split-window-right)
	(other-window 1)
	(find-file "~/org/todo.org")
	))


;; Shell, with root location in dired
(global-set-key (kbd "C-`")
				(lambda ()
				  (interactive)
				  (progn
					(anr-shell-view)
					)
				  )
				)

;; Close everything and give me a shell
(global-set-key (kbd "C-~") ;; reset
				(lambda ()
				  (interactive)
				  (progn
					(anr-shell-view)
					(other-window 1)
					(anr-connect-to-machine)
					)
				  )
				)


;; Todo view
(global-set-key (kbd "C--")
            (lambda ()
                  (interactive)
                  (progn
					(anr-todo-view)
					)))

(defalias 'anr-connect-to-machine 'anr-connect-to-local)

;; @todo: if a shell already exists, then we need to close it first
;; when switching to another machine

(defun anr-kill-buffer ()
  (interactive)
  (if (get-buffer "*shell*") (kill-buffer "*shell*"))
  )

;; @fix: if shell already exists, we have to run the function again.

(global-set-key (kbd "C-c 1")
            (lambda ()
                  (interactive)
                  (progn
					(anr-kill-buffer)
					(defalias 'anr-connect-to-machine 'anr-connect-to-local)
					(message "Machine context: %s" "Local" )
					)))

(global-set-key (kbd "C-c 2")
            (lambda ()
                  (interactive)
                  (progn
					(anr-kill-buffer)
					(defalias 'anr-connect-to-machine 'anr-connect-to-docker-2222)
					(message "Machine context: %s" "docker-2222" )
					)))

(global-set-key (kbd "C-c 3")
            (lambda ()
                  (interactive)
                  (progn
					(anr-kill-buffer)
					(defalias 'anr-connect-to-machine 'anr-connect-to-docker-2200)
					(message "Machine context: %s, Test Random Stuff.." "docker-2200" )
					)))

(global-set-key (kbd "C-c 8")
            (lambda ()
                  (interactive)
                  (progn
					(anr-kill-buffer)
					(defalias 'anr-connect-to-machine 'anr-connect-to-penneo-dev)
					(message "Machine context: %s" "Penneo Development" )
					)))

(global-set-key (kbd "C-c 9")
            (lambda ()
                  (interactive)
                  (progn
					(anr-kill-buffer)
					(defalias 'anr-connect-to-machine 'anr-connect-to-penneo-live)
					(message "Machine context: %s" "Penneo LIVE!!" )
					)))
