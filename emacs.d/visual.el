;; Visual customizations

;; Enabling tabs and tweaks
(tabbar-mode t)
(setq tabbar-cycle-scope 'tabs)
;; (load-file "~/.emacs.d/tabbar-group.el")
(load-file "~/.emacs.d/tabbar-tweak.el")

;; Paren mode
(show-paren-mode)


;; Whitespace Customizations
;; -------------------------
;; http://ergoemacs.org/emacs/whitespace-mode.html
;; make whitespace-mode use just basic coloring
(setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))
(setq whitespace-display-mappings
      '(
	;; (space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
	;; (newline-mark 10 [8617 10]) ; 10 LEFTWARDS ARROW WITH HOOK
	(tab-mark 9 [8594 9] [92 9]) ; 9 TAB, 9655 RIGHTWARDS ARROW 「→」
	))

;; Customizing the color
;; http://stackoverflow.com/questions/22011102/how-to-change-face-of-whitespace-tab-in-whitespace-mode-to-red-background-in-ema
;; (setq whitespace-style '(face tabs))
;; (setq tab-face (make-face 'tab-face))
;; (set-face-background 'tab-face "red")
;; (setq whitespace-tab 'tab-face)
;; (whitespace-mode)

;; Enable whitespace mode
(global-whitespace-mode 1)

(setq default-tab-width 4)


;; Remove tool bar (File/Edit/.. etc)
(tool-bar-mode -1)


;; Window splits
;;
;; Emacs behavior
;; (setq split-height-threshold 0)
;; (setq split-width-threshold nil)
;; Helm
;; @see http://tuhdo.github.io/helm-intro.html
(setq helm-split-window-in-side-p           t) ; open helm buffer
                                               ; inside current
                                               ; window, not occupy
                                               ; whole other window

;; Automatically shrink the window that is out of focus
;; @see: https://truongtx.me/2014/11/15/auto-resize-windows-by-golden-ratio-in-emacs/
;; (golden-ratio-mode 1)

;; -------------
;; GUI MODE ONLY
;; -------------

;; Cursor color
(set-cursor-color "#fff000") ;; make the cursor prominent

;; Remove menu bar (Cut/Copy/Paste icons)
(menu-bar-mode -1)

;; Remove the scroll bars
(scroll-bar-mode -1)

;; Font Sizes
;;
;; Configuration
(setq anr-small-font-size 80)    ;; larger screens with lower resolution
(setq anr-regular-font-size 130) ;; default on lenovo x1 carbon
(setq anr-big-font-size 150)
(setq anr-default-font-size anr-regular-font-size)
;;
;; Functions
(defun anr-set-font-size(size)
  (interactive)
  (set-face-attribute 'default nil :height size))
(defun anr-toggle-font-size()
    "Toggle between font sizes"
    (interactive)
    (setq anr-default-font-size (if (= anr-default-font-size anr-regular-font-size ) anr-small-font-size anr-regular-font-size))
    (anr-set-font-size anr-default-font-size))
;;
;; Keybindings
(global-set-key (kbd "C-0") 'anr-toggle-font-size)
;;
;; Default
(anr-set-font-size anr-default-font-size)

;; Themes
;;
;; Configuration
(setq anr-primary-theme "spolsky")
(setq anr-secondary-theme "junio")
(setq anr-default-theme anr-primary-theme)
;;
;; Functions
(defun anr-toggle-theme()
    "Toggle between themes"
    (interactive)
    (setq anr-default-theme (if (eq anr-default-theme anr-primary-theme) anr-secondary-theme anr-primary-theme))
    (load-theme (intern anr-default-theme)))
;;
;; Keybindings
(global-set-key (kbd "C-=") 'anr-toggle-theme)
;;
;; Default
;; - Loaded at startup instead of here
;; (load-theme (intern anr-default-theme))

;; Kill the current buffer and go to the last buffer
(defun anr-kill-this-buffer()
    "Kill buffer and go to the last used buffer"
    (interactive)
	(let ((buffer (current-buffer)))
	  (previous-buffer)
	  (kill-buffer buffer)))
(global-set-key (kbd "M-W") 'anr-kill-this-buffer)

;; Toggle between two windows setup horizontally or vertically
;; Only works for 2 exactly two windows
;; @see http://emacswiki.org/emacs/ToggleWindowSplit
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

