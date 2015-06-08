;; -*- mode: emacs-lisp -*-

;; ;; Customizing startup
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-safe-themes
   (quote
	("3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" default)))
 '(fci-rule-color "#383838")
 '(tabbar-separator (quote (0.5)))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
	((20 . "#BC8383")
	 (40 . "#CC9393")
	 (60 . "#DFAF8F")
	 (80 . "#D0BF8F")
	 (100 . "#E0CF9F")
	 (120 . "#F0DFAF")
	 (140 . "#5F7F5F")
	 (160 . "#7F9F7F")
	 (180 . "#8FB28F")
	 (200 . "#9FC59F")
	 (220 . "#AFD8AF")
	 (240 . "#BFEBBF")
	 (260 . "#93E0E3")
	 (280 . "#6CA0A3")
	 (300 . "#7CB8BB")
	 (320 . "#8CD0D3")
	 (340 . "#94BFF3")
	 (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Disable the default startup screen
(setq inhibit-startup-message t)


;; Initialize Packages
(package-initialize)                 ;; initializing the packages
(setq package-enable-at-startup nil) ;; so that startup time doesn't take too long
(setq package-archives
	  '(("gnu" . "http://elpa.gnu.org/packages/")
		;; ("marmalade" . "https://marmalade-repo.org/packages/")
		("melpa" . "http://melpa.milkbox.net/packages/")))

;; Theme
(load-theme 'spolsky)

;; Tramp
(setq tramp-default-method "ssh")

;; Experimental
(semantic-mode)


;; required for php-mode
(require 'cl) ;; todo: don't know what this does?

;; Tab width
(setq-default indent-tabs-mode t)
(setq tab-width 4)
(setq c-basic-offset 4)

;; PHP Mode
(add-hook 'php-mode-hook
		  '(lambda ()
			 (smart-tabs-mode-enable)
			 ;; (flymake-mode) ;; it creates inplace temp files
			 ;; compile
			 (global-set-key (kbd "<C-return>") 'compile)
			 ))
;; @see https://gist.github.com/fzerorubigd/2977839
(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)
(smart-tabs-insinuate 'c)
(smart-tabs-advice js2-indent-line js2-basic-offset)

;; JS Mode
(add-hook 'js-mode-hook
		  '(lambda ()
			 (setq indent-tabs-mode t)
			 (setq tab-width 4)
			 (setq c-basic-offset 4)))

;; web-mode
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))

;; Autocomplete
(global-auto-complete-mode)

;; Helm (Incremental completion and selection narrowing)
(helm-mode)

;; Projectile
;; @see http://tuhdo.github.io/helm-projectile.html
(projectile-global-mode)
;; Enable projectile helm integration
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(add-to-list 'projectile-globally-ignored-directories "backup")
(add-to-list 'projectile-globally-ignored-directories "tmp")
(add-to-list 'projectile-globally-ignored-directories "cache")
(add-to-list 'projectile-globally-ignored-directories "logs")
;;
;; Enable projectile caching
(setq projectile-enable-caching t)
;; Switch project action
(setq projectile-switch-project-action 'projectile-dired)

;; ansi-color
;; so that emacs shell handles console output correctly
(require 'ansi-color)
;; http://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer
(defun colorize-compilation-buffer ()
  (interactive)
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook
 'compilation-filter-hook
 ;; @todo: add magit hook when buffer displayed e.g. diff etc
 ;; added from the example
 'colorize-compilation-buffer
 )

(setq guide-key/recursive-key-sequence-flag t)
;; (setq guide-key/popup-window-position 'bottom) ;; height of the window is not automatically adjusted
(setq guide-key/guide-key-sequence '("C-x" "C-c"))
(guide-key-mode)

;; Load other files
;; (load-file "~/.emacs.d/macros.el")
(load-file "~/.emacs.d/commands.el")
(load-file "~/.emacs.d/commands-third-party.el")
(load-file "~/.emacs.d/visual.el")
(load-file "~/.emacs.d/keybindings.el")
(load-file "~/.emacs.d/registers.el")
(load-file "~/.emacs.d/custom.el")


;; (defun anr-buffer-file-name ()
;;   (interactive)
;;   (message "%s" (buffer-name))
;;   )
;; (add-hook 'magit-mode-hook 'anr-buffer-file-name)


;; @todo: They following are installed. Play with them later
;; persp-projectile   20141207.115 installed             Perspective integration with Projectile
;; perspective        20150105.... installed             switch between named "perspectives" of the editor


(setq org-startup-folded nil )


;; phpunit
(setq phpunit-configuration-file "phpunit.xml.dist")
(setq phpunit-root-directory "/var/www/Symfony/app/")
;; (setq phpunit-root-directory "/var/www/Symfony/")

;; google translate
(setq google-translate-translation-directions-alist '(("da" . "en") ("en" . "da")))

(defalias 'yes-or-no-p 'y-or-n-p)

;; Evil mode
;;
(evil-mode)
(global-evil-surround-mode)
(setq evil-want-fine-undo 'fine) ;; preserves cursor positions aswell
;; Using emacs mode as the standard insert mode
;; http://stackoverflow.com/a/28985130/1589512
(setq evil-insert-state-map (make-sparse-keymap))
(define-key evil-insert-state-map (kbd "<escape>") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)


;; temp - custom

;; http://rejeep.github.io/emacs/elisp/2010/11/16/delete-file-and-buffer-in-emacs.html
(defun delete-this-buffer-and-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))
