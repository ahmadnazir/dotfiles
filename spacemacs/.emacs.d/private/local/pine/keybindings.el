(spacemacs/declare-prefix "op" "Execute with pine")

;; Execute
(spacemacs/set-leader-keys "opx" 'pine-mode--eval-at-point)

(defun pine-mode--build-at-point()
  (interactive)
  (pine-mode--pine-build-at-point 'message))
(spacemacs/set-leader-keys "opb" 'pine-mode--build-at-point)
