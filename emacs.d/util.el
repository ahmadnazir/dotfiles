;; Edit current file as sudo
;; http://www.emacswiki.org/TrampMode#toc31
(defun sudo-edit-current-file ()
  (interactive)
  (let ((my-file-name) ; fill this with the file to open
        (position))    ; if the file is already open save position
    (if (equal major-mode 'dired-mode) ; test if we are in dired-mode
        (progn
          (setq my-file-name (dired-get-file-for-visit))
          (find-alternate-file (prepare-tramp-sudo-string my-file-name)))
      (setq my-file-name (buffer-file-name); hopefully anything else is an already opened file
            position (point))
      (find-alternate-file (prepare-tramp-sudo-string my-file-name))
      (goto-char position))))
(defun prepare-tramp-sudo-string (tempfile)
  (if (file-remote-p tempfile)
      (let ((vec (tramp-dissect-file-name tempfile)))

        (tramp-make-tramp-file-name
         "sudo"
         (tramp-file-name-user nil)
         (tramp-file-name-host vec)
         (tramp-file-name-localname vec)
         (format "ssh:%s@%s|"
                 (tramp-file-name-user vec)
                 (tramp-file-name-host vec))))
    (concat "/sudo:mandark@localhost:" tempfile)))

;; https://github.com/magnars/.emacs.d/blob/master/defuns/lisp-defuns.el
;; Lisp specific defuns
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))
(global-set-key (kbd "C-x C-e") 'eval-and-replace)


;; http://whattheemacsd.com/key-bindings.el-03.html
(global-set-key (kbd "M-k")
            (lambda ()
                  (interactive)
                  (join-line -1)))


;; http://rejeep.github.io/emacs/elisp/2010/11/16/delete-file-and-buffer-in-emacs.html
(defun delete-this-buffer-and-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))


;; Open the most recently killed buffer
;; http://emacs.stackexchange.com/questions/3330/how-to-reopen-just-killed-buffer-like-c-s-t-in-firefox-browser
(defvar killed-file-list nil
  "List of recently killed files.")
(defun add-file-to-killed-file-list ()
  "If buffer is associated with a file name, add that file to the
`killed-file-list' when killing the buffer."
  (when buffer-file-name
    (push buffer-file-name killed-file-list)))
(add-hook 'kill-buffer-hook #'add-file-to-killed-file-list)
(defun reopen-killed-file ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (when killed-file-list
    (find-file (pop killed-file-list))))
(define-key global-map (kbd "M-T") 'reopen-killed-file)


(defun anr-shell (buffer)
  "Opens a new shell buffer where the given buffer is located."
  (interactive "sBuffer: ")
  (pop-to-buffer (concat "*" buffer "*"))
  (unless (eq major-mode 'shell-mode)
    ;; (dired buffer)
    (shell buffer)
    ))
(global-set-key (kbd "C-`") 'anr-shell)


(defun an-buffer-string (buffer)
  "Get the contents of a buffer"
  (with-current-buffer buffer
    (buffer-string)))

;; @see http://emacswiki.org/emacs/InsertingTodaysDate
(defun date (arg)
   (interactive "P")
   (insert (if arg
               (format-time-string "%d.%m.%Y")
             (format-time-string "%Y-%m-%d"))))

(defun anr-shell-region (start end)
  "Execute region in an inferior shell"
  (interactive "r")
  (kill-buffer "**Shell**")
  ;; @todo: if the paragraph is modified, an error is thrown if I use
  ;; mark-paragraph here. I am sure it is related to my cursor
  ;; position
  ;; (mark-paragraph)
  (call-process-shell-command (buffer-substring-no-properties start end) nil "**Shell**")
  (switch-to-buffer-other-window "**Shell**")
  (other-window -1)
  )


;; http://ergoemacs.org/emacs/dired_sort.html
(defun an-xah-dired-sort ()
  "Sort dired dir listing in different ways.
Prompt for a choice.
URL `http://ergoemacs.org/emacs/dired_sort.html'
Version 2015-07-30"
  (interactive)
  (let (ξsort-by ξarg)
    (setq ξsort-by (ido-completing-read "Sort by:" '( "date" "size" "name" "dir")))
    (cond
     ((equal ξsort-by "name") (setq ξarg "-Al --si --time-style long-iso "))
     ((equal ξsort-by "date") (setq ξarg "-Al --si --time-style long-iso -t"))
     ((equal ξsort-by "size") (setq ξarg "-Al --si --time-style long-iso -S"))
     ((equal ξsort-by "dir") (setq ξarg "-Al --si --time-style long-iso --group-directories-first"))
     (t (error "logic error 09535" )))
    (dired-sort-other ξarg )))


;; http://stackoverflow.com/a/6541072/1589512
(defun func-region (start end func)
  "run a function over the region between START and END in current buffer."
  (save-excursion
    (let ((text (delete-and-extract-region start end)))
      (insert (funcall func text)))))
(defun hex-region (start end)
  "urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-hexify-string))
(defun unhex-region (start end)
  "de-urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-unhex-string))
