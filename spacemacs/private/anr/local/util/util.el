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
(defun util/date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d.%m.%Y")
            (format-time-string "%Y-%m-%d"))))

;;;###autoload
(defun util/make-executable ()
  (interactive)
  (shell-command (concat "chmod u+x " (shell-quote-argument buffer-file-name) " && echo Updated '" buffer-file-name "'")))


(provide 'util)
