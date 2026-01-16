;;; bolt.el --- Give your text superpowers -*- lexical-binding: t -*-

;; Author: Ahmad Nazir Raja <ahmadnazir@gmail.com>
;; Version: 0.0.1
;; Package-Requires: ((s "1.10.0"))
;; Package-Requires: ((helm "3.6.0"))
;; URL: https://github.com/ahmadnazir/bolt

(require 's)
(require 'helm)

;;; Code:

(defcustom bolt--script-dir "~/.bolt"
  "Directory where scripts are stored that will be used by bolt")

(defcustom bolt--output-buffer "**bolt**"
  "Bolt output buffer name")

(defun bolt--paragraph-at-point()
  "Paragraph at point"
  (let ((start (save-excursion
                 (backward-paragraph)
                 (point)))
        (end (save-excursion
               (forward-paragraph)
               (point))))
    (buffer-substring-no-properties start end)))

(defun bolt--get-argument ()
  (if (use-region-p)
      (buffer-substring (mark) (point))
    (bolt--paragraph-at-point)))

(defun bolt--run-cmd (cmd)
  (shell-command-to-string cmd)
  ;; (shell-command-to-string (s-join " " `("cd" ,bolt--script-dir "&&" ,cmd)))
  )

(defun bolt--get-scripts ()
  (split-string (bolt--run-cmd (concat "ls " bolt--script-dir))))

(defun bolt--helm-scripts ()
  "Helm source for bolt scripts"
  `((name . "Select command:")
    (candidates . bolt--get-scripts)
    (action . (lambda (candidate)
                (bolt--output (lambda() (bolt--run-cmd (concat ,bolt--script-dir "/" candidate " '" ,(bolt--get-argument) "'"))))))))

(defvar bolt--helm-actions
  '((name . "Default execution action:")
    (candidates . (("bolt--execute-cmd" 'bolt--execute-cmd)
                   ("bolt--execute-word" 'bolt--execute-word)
                   ("eval-defun" 'eval-defun)
                   ))
    (action . (lambda (candidate)
                (local-set-key (kbd "<C-return>") (car (cdr (car candidate))))
                )))
  "Helm source for bolt actions"
  )

;;;###autoload
(defun bolt--execute ()
  "Use selected string or sentence as point as an argument for a
command. The output is written the the *Messages* buffer and
copied to the clipboard."
  (interactive)
  (helm :sources (bolt--helm-scripts)))

;;;###autoload
(defun bolt--execute-cmd ()
  "Select the line to be executed as the command in the shell."
  (interactive)
  (let ((cmd (bolt--get-argument)))
    (bolt--output (lambda() (shell-command-to-string cmd)))))


(defun bolt--output (fn)
    "Call the fn and output the results"
  (let ((b (get-buffer bolt--output-buffer)))
    (if b (switch-to-buffer-other-window b)
      (switch-to-buffer-other-window bolt--output-buffer))
    (message "Loading...")
    (let ((output (funcall fn)))
      (erase-buffer)
      (insert output))
    (beginning-of-buffer)
    (other-window 1)
    (message "Done!")
    ))

;; TODO: make it buffer specific
(defcustom bolt--default-cmd "echo Default command not configured. Configure a command: M-x customize-variable bolt--default-cmd"
  "Bolt default command")

;;;###autoload
(defun bolt--execute-default-cmd ()
  "Execute bolt default command"
  (interactive)
  (bolt--output (lambda() (shell-command-to-string bolt--default-cmd))))


(provide 'bolt)

;;; bolt.el ends here
