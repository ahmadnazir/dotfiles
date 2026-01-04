;; TODO: use defcustom
(setq visual/regular-font-size 14) ;; works for lenovo x1 carbon
(setq visual/large-font-size   17) ;; zoom in for accessibility

;; Defaults
(setq visual/default-font "Source Code Pro")
(setq visual/default-font-size visual/regular-font-size)

;;;###autoload
(defun visual/set-font(font size)
  (interactive)
  (set-face-font 'default (concat font " " (number-to-string size))))

;;;###autoload
(defun visual/toggle-font-size()
  "Toggle between font sizes"
  (interactive)
  (setq visual/default-font-size (if (= visual/default-font-size visual/regular-font-size ) visual/large-font-size visual/regular-font-size))
  (visual/set-font visual/default-font visual/default-font-size))

;; TODO move to separate file - begin
;;;###autoload
(defun anr-visual--show (f)
  "Show the contents of the file in another window (keeping the control in the same window)"
  (progn
    (let* ((b (get-file-buffer f)))
      (if b (switch-to-buffer-other-window b)
        (switch-to-buffer-other-window (find-file-noselect f))))
    (other-window 1)))
;; end

(provide 'visual)
