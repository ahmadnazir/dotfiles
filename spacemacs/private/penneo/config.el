;;;  -*- lexical-binding: t -*-

(setq penneo-code-dir "/home/mandark/code/forks/penneo/")


;; (prodigy-define-tag
;;  :name 'docker
;;  :on-output (lambda (&rest args)
;;               (let ((service (plist-get args :service)))
;;                 (prodigy-set-status service 'ready)
;;                 (if (eq 0 (shell-command (concat  "docker ps | grep " (plist-get service :name))))
;;                     (prodigy-set-status service 'running)
;;                   (prodigy-set-status service 'failed)
;;                   )
;;                 )))

