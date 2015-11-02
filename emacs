;; -*- mode: emacs-lisp -*-

;; Customizing startup
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(auto-dim-other-buffers-face ((t (:background "gray15"))))
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" default)))
 '(fci-rule-color "#383838")
 '(golden-ratio-mode nil)
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
 '(auto-dim-other-buffers-face ((t (:background "gray15")))))

;; Disable the default startup screen
(setq inhibit-startup-message t)

;; Need to add the following to prelude-packages
;; @see http://stackoverflow.com/questions/13866848/how-to-save-a-list-of-all-the-installed-packages-in-emacs-24
;;
;; (diff-hl diff-hl git-gutter 2048-game ac-helm popup auto-complete popup helm async ace-jump-buffer dash ace-jump-mode ace-jump-mode auto-complete popup auto-dim-other-buffers csharp-mode dash-functional dash deferred dockerfile-mode evil-escape evil goto-chg undo-tree evil-surround evil-visualstar evil goto-chg undo-tree expand-region f dash s flymake-php flymake-easy flymake-yaml flymake-easy fullscreen-mode function-args swiper geben god-mode golden-ratio google-translate goto-chg guide-key s popwin dash haskell-mode helm-ag helm async helm-gist gist gh logito pcache helm async helm-hoogle helm async helm-projectile dash projectile pkg-info epl dash helm async helm-themes helm async hyde inf-php php-mode js-comint keyfreq logito magit-tramp magit magit-popup dash git-commit with-editor dash dash with-editor dash dash markdown-mode multiple-cursors org org-journal paredit pcache persp-projectile projectile pkg-info epl dash perspective perspective php-auto-yasnippets yasnippet php-mode php-mode popup popwin projectile pkg-info epl dash puppet-mode pkg-info epl s shift-text es-lib skewer-mode js2-mode simple-httpd smart-tabs-mode speed-type sqlup-mode sublime-themes swiper tabbar tern undo-tree web-mode windata with-editor dash xclip xkcd yaml-mode yasnippet zenburn-theme)


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
;; @see: https://github.com/bbatsov/projectile/issues/139
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq c-basic-offset 4)

;; @see https://gist.github.com/fzerorubigd/2977839
(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)
(smart-tabs-insinuate 'c)
(smart-tabs-advice js2-indent-line js2-basic-offset)


;; Recognizing file extensions
;; (add-to-list 'auto-mode-alist '("\\emacs\\'" . emacs-lisp-mode)) ;; @fix: can't have the mode line as the first in the file because of flycheck
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig\\'" . web-mode))

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
;; (setq projectile-switch-project-action 'projectile-dired)

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
(load-file "~/.emacs.d/util.el")
(load-file "~/.emacs.d/crypt.el")
(load-file "~/.emacs.d/dev.el")
(load-file "~/.emacs.d/custom.el")
(load-file "~/.emacs.d/system.el")
(load-file "~/.emacs.d/visual.el")
(load-file "~/.emacs.d/keybindings.el")
(load-file "~/.emacs.d/hooks.el")
(load-file "~/.emacs.d/experiment.el")
;; @todo: should be removed
(load-file "~/.emacs.d/registers.el")


;; @todo: They following are installed. Play with them later
;; persp-projectile   20141207.115 installed             Perspective integration with Projectile
;; perspective        20150105.... installed             switch between named "perspectives" of the editor


(setq org-startup-folded nil )


;; phpunit
;;
;; @todo: this should go in the .dir-locals.el
(setq phpunit-configuration-file "phpunit.xml.dist")
(setq phpunit-root-directory "/app/data/app/")
;; (setq phpunit-root-directory "/var/www/Symfony/")

;; google translate
(setq google-translate-translation-directions-alist '(("da" . "en") ("en" . "da")))

(defalias 'yes-or-no-p 'y-or-n-p)

;; Evil mode
;;
;; Before turning on evil mode, we need to disable the default tab functionality in evil mode
;; @see: http://stackoverflow.com/a/22922161
(setq evil-want-C-i-jump nil)
;;
(evil-mode)
(global-evil-surround-mode)
(setq evil-want-fine-undo 'fine) ;; preserves cursor positions aswell
;; Using emacs mode as the standard insert mode
;; http://stackoverflow.com/a/28985130/1589512
(setq evil-insert-state-map (make-sparse-keymap))
(define-key evil-insert-state-map (kbd "<escape>") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

;; Electric Pair Mode
(electric-pair-mode)

;; Auto dim other buffers
(auto-dim-other-buffers-mode)

;; Enable vc highliging
(global-diff-hl-mode)

;; Dired configuration
(setq dired-dwim-target t)


;; Override selected text with what I type
;; (delete-selection-mode 1)


;; For some reason emacs doesn't reconize the path set in the zshrc
;; file (or bashrc file)
(exec-path-from-shell-initialize)


;; JS code conventions
;;
;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)
;;
;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
;;
;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)
;;
(setq-default
 flycheck-disabled-checkers
 (append flycheck-disabled-checkers
         '(
           ;; disable jshint since we prefer eslint checking
           javascript-jshint
           ;; I'll enable this once I am ready to refactor my emacs
           ;; files
           emacs-lisp
           emacs-lisp-checkdoc
           )))

(provide 'emacs)

;;; emacs ends here
