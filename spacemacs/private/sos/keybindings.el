(add-hook 'sql-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'exsqlaim/sql-send-paragraph)
             ;; (sql-set-sqli-buffer-generally)
             ))

