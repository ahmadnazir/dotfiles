;; SQL mode
;;
;; For related setup, @see: https://truongtx.me/2014/08/23/setup-emacs-as-an-sql-database-client/
(add-hook 'sql-mode-hook
          '(lambda ()
             (global-set-key (kbd "<C-return>") 'sql-send-paragraph)
             (sql-set-sqli-buffer-generally)
             ))

;; SQL interactive mode
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

;; PHP Mode
;;
(add-hook 'php-mode-hook
          '(lambda ()
             (smart-tabs-mode-enable)
             ;; (flymake-mode) ;; disabling it, as it creates temp files in the same directory
             ;; compile
             (global-set-key (kbd "<C-return>") 'compile)
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
(add-hook 'js-mode-hook
          '(lambda ()
             (setq indent-tabs-mode t)
             (setq tab-width 4)
             (setq c-basic-offset 4)
             (c-set-offset 'case-label '+)
             ))

;; Shell script mode
;;
(add-hook 'sh-mode-hook
          '(lambda ()
             (global-set-key (kbd "<C-return>") 'anr-shell-region)
             ))

;; Haskell Mode
;;
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook
          '(lambda ()
             (structured-haskell-mode)
             ;; (haskell-unicode)
             ))


