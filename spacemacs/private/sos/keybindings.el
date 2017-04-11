(add-hook 'sql-mode-hook
          '(lambda ()
             (local-set-key (kbd "<C-return>") 'sos/sql-send-paragraph)
             ;; (sql-set-sqli-buffer-generally)
             ))

