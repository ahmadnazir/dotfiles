;; ;;;###autoload
;; (defun sql-wrapper/connect(connection &optional new-name)
;;   "Wrapper for sql connect"
;;   (interactive)
;;   (progn () (
;;              (sql-mode)
;;              (setq sql-product 'mysql)
;;              (sql-connect connection new-name)
;;              ))
;;   )

;; A variable can be defined as:
;;
;; @db = "test"
;;
(defconst sos/var-regexp "^\\(@[^@ ]+\\)[ \t]*=[ \t]*\\(.*\\)$")

;; Inspired and modified from restclient.el: restclient-find-vars-before-point
(defun sos/find-vars-before-point ()
  (let ((vars nil)
        (bound (point)))
    (save-excursion
      (goto-char (point-min))
      (while (search-forward-regexp sos/var-regexp bound t)
        (let ((name (match-string-no-properties 1))
              (value (match-string-no-properties 2)))
          (setq vars (cons (cons name (message value)) vars))))
      vars)))

(defun sos/get-vars ()
  (cons
   '(";"."\\p;") ;; echo the query to the terminal
   (sos/find-vars-before-point)))

;; Overriding the sql send region so that I can replace the query params
(defun sql-send-region (start end)
  "Send a region to the SQL process."
  (interactive "r")
  (sql-send-string (buffer-substring-no-properties start end)))

;; Modified the original function from sql.el
(defun sos/sql-send-region (start end)
  "Send a region to the SQL process."
  (interactive "r")
  (sql-send-string
   (s-replace-all (sos/get-vars)
                  (buffer-substring-no-properties start end)))
  )

;; Modified the original function from sql.el
(defun sos/sql-send-paragraph ()
  "Send the current paragraph to the SQL process."
  (interactive)
  (let ((start (save-excursion
                 (backward-paragraph)
                 (point)))
        (end (save-excursion
               (forward-paragraph)
               (point))))
    (sos/sql-send-region start end)))

(provide 'sos)
