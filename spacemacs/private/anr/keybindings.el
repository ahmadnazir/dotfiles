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

;; clojure-mode
(add-hook 'clojure-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'cider-eval-defun-at-point)
             ))

;; Buffers
;;
(global-set-key (kbd "M-O" ) '(lambda() (interactive) (other-window  1)))
(global-set-key (kbd "M-S-SPC") 'window/toggle-window-split)
;; (global-set-key (kbd "M-S-k" ) 'spacemacs/kill-this-buffer) ;; @fixme: doesn't work

;; Visual
;;
;; @todo: use spacemacs conventions
(global-set-key (kbd "C-0") 'visual/toggle-font-size)

;; Legacy

;; not so spacemacs friendly commands
;;
(global-set-key (kbd "M-U")  'previous-buffer)
(global-set-key (kbd "M-I")  'next-buffer)

