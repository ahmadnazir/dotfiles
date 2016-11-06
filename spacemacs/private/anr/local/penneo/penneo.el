;;;###autoload
(defun penneo/-generate-auth-token (url username password)
  "Generate an authentication token for the development environment"
  (eshell-command
   (concat "curl -i "
           "-H 'Content-Type: application/json' "
           "-H 'Accept: application/json' "
           "-H 'Accept-charset: utf-8' "
           "-XPOST '" url "' "
           ;; use a library to json encode
           "-d '{ \"username\": \"" username "\",\"password\": \"" password"\" } '")))

;;;###autoload
(defun penneo/-auth-token-file (env)
  (concat "~/.penneo-auth-token-" env))

;;;###autoload
(defun penneo/generate-auth-token ()
  (interactive)
  (let (
        (env (read-string "Environment: " "local"))
        (url (read-string "Url: " "http://localhost:8002/app_dev.php/api/v1/token/password"))
        (username (read-string "Username: " ""))
        (password (read-string "Password: " ""))
        )
    (progn
      (penneo/-generate-auth-token url username password)
      (other-window 1)
      (end-of-buffer)
      (eshell-command (concat "echo '" (thing-at-point 'line) "' > " (penneo/-auth-token-file env))) ;; closes the buffer real quick for some reason
      ;; (other-window 1)
      (spacemacs/delete-window)
      (message (concat  "Auth token created at : " (penneo/-auth-token-file env)))
      )))

(provide 'penneo)
