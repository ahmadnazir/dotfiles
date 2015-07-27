;; Disable the touchpad when emacs is focused
;;
;; @see: https://www.reddit.com/r/emacs/comments/38o0tr/i_have_to_share_this_switch_your_touchpad_off/
;;
;; @todo: Maybe this will give some problems on tramp. Also there is a
;; recommendation about using synclient but the following is working
;; fine for me so don't need to look into it any further
(defun turn-off-mouse (&optional frame)
  (interactive)
  (shell-command "xinput --disable \"SynPS/2 Synaptics TouchPad\""))
(defun turn-on-mouse (&optional frame)
  (interactive)
  (shell-command "xinput --enable \"SynPS/2 Synaptics TouchPad\""))
(add-hook 'focus-in-hook #'turn-off-mouse)
(add-hook 'focus-out-hook #'turn-on-mouse)
(add-hook 'delete-frame-functions #'turn-on-mouse)
