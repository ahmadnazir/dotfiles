;;;###autoload
(defun crypt/sha (string)
  "Take sha 256 and copy to the killring"
  (interactive "sString: ")
  (progn () (message (concat "Copied to killring: " (kill-new (secure-hash 'sha256 string)))))
  )

(provide 'crypt)
