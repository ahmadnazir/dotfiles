(add-hook 'sql-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'exsqlaim-mode--send)
             ;; (sql-set-sqli-buffer-generally)
             ))

