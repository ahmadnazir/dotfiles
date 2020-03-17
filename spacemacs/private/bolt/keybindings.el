(spacemacs/declare-prefix "ox" "Execute with bolt")

;; Execute
(spacemacs/set-leader-keys "ox." 'bolt--execute)
(spacemacs/set-leader-keys "oxx" 'bolt--execute-cmd)

;; setup
(spacemacs/set-leader-keys "oxB" 'bolt--set-key-binding-m-return)
