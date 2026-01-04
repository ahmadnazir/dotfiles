;;; packages.el --- anr layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Ahmad Nazir Raja <mandark@mandark>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `anr-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `anr/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `anr/pre-init-PACKAGE' and/or
;;   `anr/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst anr-packages
  '(
    (util :location local)
    (visual :location local)
    ;; (window :location local)
    ;; (crypt :location local)
    ;; (plantuml :location local)
    ;; (copilot :location local)
    )
  "The list of Lisp packages required by the anr layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun anr/init-util ()
  "Initialize util package"
  (use-package util)
  )

(defun anr/init-visual ()
  "Initialize visual package"
  (use-package visual)
  )

(defun anr/init-window ()
  "Initialize window package"
  (use-package window)
  )

(defun anr/init-crypt()
  "Initialize crypt package"
  (use-package crypt)
  )

(defun anr/init-plantuml()
  "Initialize plantuml package"
  (use-package plantuml)
  )

;; (defun anr/init-copilot()
;;   "Initialize copilot package"
;;   (use-package copilot)
;;   )
;;; packages.el ends here
