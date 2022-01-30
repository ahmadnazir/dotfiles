(defun avallone-api--get-string (start end)
  "Get the raw query with variables.
Argument START Point where the query starts.
Argument END Point where the query ends."
  (interactive)
  (buffer-substring-no-properties start end))

(defun avallone-api--save-xsrf-token()
  "Save the xsrf token to disk"
  (interactive)
  (save-excursion
    (let ((start (progn
                   (beginning-of-buffer)
                   (search-forward-regexp "XSRF-TOKEN=")
                   (point)
                   ))
          (end (progn
                 (search-forward-regexp ";")
                 (backward-char)
                 (point))))


      ;; debug
      ;; (message (avallone-api--get-string start end))
      (write-region start end "/home/mandark/.secrets/avallone/xsrf")))
  )
