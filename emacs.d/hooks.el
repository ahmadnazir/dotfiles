;; SQL mode
;;
;; For related setup, @see: https://truongtx.me/2014/08/23/setup-emacs-as-an-sql-database-client/
(add-hook 'sql-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'sql-send-paragraph)
             (sql-set-sqli-buffer-generally)
             (yas-global-mode)
             (yas-minor-mode)
             ))

;; SQL interactive mode
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

;; PHP Mode
;;
(add-hook 'php-mode-hook
          '(lambda ()
             ;; (smart-tabs-mode-enable) ;; should be set in dir-locals
             ;; (flymake-mode) ;; disabling it, as it creates temp files in the same directory
             ;; compile
             (local-set-key (kbd "<C-return>") 'compile)
             ;; yasnippet
             (define-key php-mode-map (kbd "C-c C-y") 'yas/create-php-snippet)
             ))

;; C Mode
;;
;; 'switch case' indentation for all the c-based programming modes
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-offset 'case-label '+)
            ))
;; JS Mode
;;
(add-hook 'js2-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq tab-width 4)
             (setq c-basic-offset 4)
             (c-set-offset 'case-label '+)
             ))

;; Shell script mode
;;
(add-hook 'sh-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'anr-shell-region)
             ))

;; Haskell Mode
;;
(add-hook 'haskell-mode-hook
          '(lambda ()
             (turn-on-haskell-indentation)
             ;; (structured-haskell-mode)
             ;; (haskell-unicode)
             ))


;; Elm Mode
;;
(add-hook 'elm-mode-hook
          '(lambda ()
             (local-set-key (kbd "<M-return>") 'elm-repl-load)
             (local-set-key (kbd "<C-return>") 'elm-repl-push)
             ))
(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)


;; Before save
(add-hook 'before-save-hook 'anr-sudo-before-save-hook)

;; Helper function to remove hooks
;;
;; (remove-hook 'elm-mode-hook (first elm-mode-hook))
