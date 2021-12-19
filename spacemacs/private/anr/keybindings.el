(message "~/spacemacs/private/anr/keybindings.el is disabled")

;; ;; Helper function to remove hooks
;; ;;
;; ;; (remove-hook 'clojure-mode-hook (first clojure-mode-hook))

;; (spacemacs/declare-prefix "o" "custom")

;; ;; ;; Hooks

;; ;; emacs-lisp-mode
;; (add-hook 'emacs-lisp-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "<C-return>") 'eval-defun)
;;              ))

;; ;; restclient-mode
;; (add-hook 'restclient-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "<C-return>") 'restclient-http-send-current-stay-in-window)
;;              ))

;; ;; clojure-mode
;; (add-hook 'clojure-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "<C-return>") 'cider-eval-defun-at-point)
;;              ))

;; (defun python-shell-send-region-at-point (&optional send-main msg)
;;   "Testing"
;;   (interactive)
;;   (let ((start (save-excursion
;;                  (backward-paragraph)
;;                  (point)))
;;         (end (save-excursion
;;                (forward-paragraph)
;;                (point))))
;;     (python-shell-send-region start end send-main msg)))

;; ;; python-mode
;; (add-hook 'python-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "<C-return>") 'python-shell-send-region-at-point)
;;              ))

;; ;; csharp-mode
;; (add-hook 'csharp-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "<C-return>") 'omnisharp-auto-complete)
;;              ))

;; ;; Buffers
;; ;;

;; ;; Visual
;; ;;
;; ;; @todo: use spacemacs conventions
;; (global-set-key (kbd "C-0") 'visual/toggle-font-size)


;; ; org journal
;; (spacemacs/declare-prefix "oj" "journal")
;; (spacemacs/set-leader-keys "ojn" 'org-journal-new-entry)
;; (spacemacs/set-leader-keys "ojb" 'org-journal-open-previous-entry)
;; (spacemacs/set-leader-keys "ojf" 'org-journal-open-next-entry)

;; ; clock !
;; (spacemacs/declare-prefix "oc" "clock")
;; (spacemacs/set-leader-keys "ocd" 'org-clock-display)
;; (spacemacs/set-leader-keys "oci" '(lambda() (interactive) (org-clock-in) (save-buffer)))
;; (spacemacs/set-leader-keys "oco" '(lambda() (interactive) (org-clock-out) (save-buffer)))
;; (spacemacs/set-leader-keys "ocr" '(lambda() (interactive)
;;                                     (beginning-of-buffer)
;;                                     (evil-open-below 0)
;;                                     (org-clock-report)
;;                                     (save-buffer)
;;                                     (evil-force-normal-state)
;;                                     ))

;; (spacemacs/set-leader-keys "or" 'helm-global-mark-ring)

;; ;; the following doesn't seem to work
;; (spacemacs/declare-prefix-for-mode 'org-journal-mode "o" "custom")
;; (spacemacs/set-leader-keys-for-major-mode 'org-mode "oc" 'org-ctrl-c-ctrl-c)

;; ;; Legacy

;; ;; visual
;; ;; (global-set-key (kbd "M-O" ) '(lambda() (interactive) (other-window  1)))
;; (global-set-key (kbd "M-S-SPC") 'window/toggle-window-split)

;; ;; git
;; (global-set-key (kbd "M-n") 'git-gutter+-next-hunk)
;; (global-set-key (kbd "M-p") 'git-gutter+-previous-hunk)
;; ;; diff-hl
;; (global-set-key (kbd "M-=") 'diff-hl-diff-goto-hunk)

;; ;; (global-set-key (kbd "C-c i") '(lambda() (interactive) (org-clock-in) (save-buffer)))
;; ;; (global-set-key (kbd "C-c o") '(lambda() (interactive) (org-clock-out) (save-buffer)))
;; ;; (global-set-key (kbd "C-c r") '(lambda() (interactive) (org-clock-report) (save-buffer)))

;; ;; (global-set-key (kbd "C-c c c" ) '(lambda() (interactive) (anr-pumlator--record-sequence nil)))
;; ;; (global-set-key (kbd "C-c c r" ) '(lambda() (interactive) (anr-pumlator--render nil)))
