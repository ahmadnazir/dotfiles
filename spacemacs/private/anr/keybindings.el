;; git-gutter
(global-set-key (kbd "M-n") 'git-gutter+-next-hunk)
(global-set-key (kbd "M-p") 'git-gutter+-previous-hunk)

;; diff-hl
(global-set-key (kbd "M-=") 'diff-hl-diff-goto-hunk)

;; ;; Hooks

;; emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'eval-defun)
             ))

;; restclient-mode
(add-hook 'restclient-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'restclient-http-send-current-stay-in-window)
             ))

(add-hook 'sql-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'sql-send-paragraph)
             ;; (sql-set-sqli-buffer-generally)
             ))

;; Visual
;;
;; @todo: use spacemacs conventions
(global-set-key (kbd "C-0") 'visual/toggle-font-size)

;; Legacy

;; not so spacemacs friendly commands
;;
(global-set-key (kbd "M-U")  'previous-buffer)
(global-set-key (kbd "M-I")  'next-buffer)

