;; Helm projectile
(global-set-key (kbd "M-F") 'helm-projectile)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c s") 'projectile-grep)

;; Buffer navigation (Similar to Chrome navigation except that in a
;; brower the windows contents are modified when we go back and forth
;; to a website, but here we have all the buffers opened and we
;; navigate back and forth the buffers)
(global-set-key (kbd "<M-left>")   'previous-buffer)
(global-set-key (kbd "<M-right>")  'next-buffer)
;; Closer to the home row
(global-set-key (kbd "M-U")  'previous-buffer)
(global-set-key (kbd "M-I")  'next-buffer)

;; Tab Navigation (Similar to Chrome tabs)
(global-set-key (kbd "<C-prior>") 'tabbar-backward)
(global-set-key (kbd "<C-next>")  'tabbar-forward)
;; Closer to the home row
(global-set-key (kbd "M-J")  'tabbar-backward)
(global-set-key (kbd "M-K")  'tabbar-forward)

(global-set-key (kbd "<M-prior>") 'tabbar-backward-group)
(global-set-key (kbd "<M-next>")  'tabbar-forward-group)
;; Closer to the home row
(global-set-key (kbd "M-H") 'tabbar-backward-group)
(global-set-key (kbd "M-L")  'tabbar-forward-group)

;; Window navigation
(global-set-key (kbd "<M-S-left>" ) '(lambda() (interactive) (other-window -1)))
(global-set-key (kbd "<M-S-right>" ) '(lambda() (interactive) (other-window  1)))
;; Home-row
;; (global-set-key (kbd "M-B" ) '(lambda() (interactive) (other-window -1)))
(global-set-key (kbd "M-O" ) '(lambda() (interactive) (other-window  1)))

;; Frame specific commands
(global-set-key (kbd "M-W") 'kill-this-buffer)
(global-set-key (kbd "M-S") 'save-buffer)

;; Expand region
;; (global-set-key (kbd "<M-up>") 'er/expand-region)     ;; deprecate in favour of other keybinding
;; (global-set-key (kbd "<M-down>") 'er/contract-region) ;; deprecate in favour of other keybinding
;; Note:
;; M-p and M-n are also bound to auto-complete-mode's commands. This
;; means that we have mode specific bindings now.. hmm..
(global-set-key (kbd "M-'")  'er/expand-region)        ;; experimental
(global-set-key (kbd "M-\"") 'er/contract-region)      ;; experimental

;; Shift text
;; In org-mode, M up and down is drag element up or down
(global-set-key (kbd "<C-S-up>")    'shift-text-up)
(global-set-key (kbd "<C-S-down>")  'shift-text-down)
(global-set-key (kbd "<C-S-right>") 'shift-text-right)
(global-set-key (kbd "<C-S-left>")  'shift-text-left)
;; Home-row
(global-set-key (kbd "C-S-p")    'shift-text-up)
(global-set-key (kbd "C-S-n")  'shift-text-down)
(global-set-key (kbd "C-S-b") 'shift-text-right)
(global-set-key (kbd "C-S-f")  'shift-text-left)

;; OVERRIDES

;; emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook
		  '(lambda ()
			 (local-set-key (kbd "<C-return>") 'eval-defun)
			 ))

;; emacs-lisp-mode
(add-hook 'org-mode-hook
		  '(lambda ()
			 (local-set-key (kbd "<M-left>")   'previous-buffer)
			 (local-set-key (kbd "<M-right>")  'next-buffer)
			 ))

;; help-mode
(add-hook 'help-mode-hook
		  '(lambda ()
			 (local-set-key (kbd "<M-left>") 'help-go-back)
			 (local-set-key (kbd "<M-right>") 'help-go-forward)
			 ))

;; restclient-mode
(add-hook 'restclient-mode-hook
		  '(lambda ()
			 (local-set-key (kbd "<C-S-return>") 'restclient-http-send-current)
			 (local-set-key (kbd "<C-return>") 'restclient-http-send-current-stay-in-window)
			 ))

;; ;; drag-stuff-mode
;; (add-hook 'drag-stuff-mode-hook
;; 		  '(lambda ()
;; 			 (local-set-key (kbd "<C-S-up>")    'drag-stuff-up)
;; 			 (local-set-key (kbd "<C-S-down>")  'drag-stuff-down)
;; 			 (local-set-key (kbd "<C-S-right>") 'drag-stuff-right)
;; 			 (local-set-key (kbd "<C-S-left>")  'drag-stuff-left)
;; 			 ))


;; multipile-cursors
(global-set-key (kbd "C-C C-C") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-!") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-,") 'set-rectangular-region-anchor)

;; magit
(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "M-p") 'magit-blame-previous-chunk)
(global-set-key (kbd "M-n") 'magit-blame-next-chunk)

;; phpunit
(global-set-key (kbd "C-c u t") 'phpunit-current-test)
(global-set-key (kbd "C-c u c") 'phpunit-current-class)
(global-set-key (kbd "C-c u p") 'phpunit-current-project)

;; Translate
(global-set-key (kbd "C-c t") 'google-translate-smooth-translate)
