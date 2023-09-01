;; Read file content into a string
;; @see http://ergoemacs.org/emacs/elisp_read_file_content.html
;;
;;;###autoload
(defun util/get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

;;;###autoload
(defun util/insert-date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d.%m.%Y")
            (format-time-string "%Y-%m-%d"))))

;;;###autoload
(defun util/insert-date-time (arg)
  (interactive "P")
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))



;;;###autoload
(defun util/insert-empty-guid ()
  (interactive)
  (insert "00000000-0000-0000-0000-000000000000")
  )

;;;###autoload
(defun util/insert-my-guid ()
  (interactive)
  (insert "24242424-2424-2424-2424-242424242424"))

;;;###autoload
(defun util/make-executable ()
  (interactive)
  (shell-command (concat "chmod u+x " (shell-quote-argument buffer-file-name) " && echo Done!")))

;;;###autoload
(defun util/magit-status-yadm()
  "TODO: move to it's own package"
  (interactive)
  (magit-status "/yadm::")
  )


;; Scribbles
;; TODO: create a scribbles package

;;;###autoload
(defun scribble ()
  (interactive)
  (let* ((rel-path (format-time-string "%Y/%m/%d/"))
         (title (read-string "What do want to scribble about? "))
         (tags (read-string "Tags: "))
         (scribbles-path "~/.scribbles/")
         (scribble-file (concat scribbles-path rel-path (s-dashed-words title) ".rst"))
         (time (format-time-string "%b %d, %Y"))
         (underline (s-replace-regexp "." "=" title))
         )
    (find-file scribble-file)
    (unless (file-exists-p scribble-file)
      (insert title "\n" underline "\n\n" ".. post:: " time "\n   " ":tags: " tags "\n\n"))))

(provide 'util)
