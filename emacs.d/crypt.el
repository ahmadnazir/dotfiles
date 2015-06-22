(defun anr-sha (string)
  "Take sha 256 and copy to the killring"
  (interactive)
  (progn () (kill-new (secure-hash 'sha256 string)) ))
