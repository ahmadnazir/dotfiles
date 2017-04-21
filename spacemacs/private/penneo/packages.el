;;; packages.el --- penneo layer packages file for Spacemacs.
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
;; added to `penneo-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `penneo/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `penneo/pre-init-PACKAGE' and/or
;;   `penneo/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst penneo-packages
  '(
    (penneo-auth :location local)
    (prodigy)
    )
  "The list of Lisp packages required by the penneo layer.

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

(defun penneo/init-penneo-auth ()
  "Initialize penneo-auth package"
  (use-package penneo-auth)
  )

(defun penneo/post-init-prodigy()
  "Initialize window package"

  (prodigy-define-service
    :name "gateway"
    :command (concat penneo-code-dir "gateway-service/project-runner/run.sh")
    :args '("dev" "up")
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop nil)

  (prodigy-define-service
    :name "frontend"
    :command "npm"
    :args '("run" "start")
    :cwd (concat penneo-code-dir "fe-application-loader")
    :kill-process-buffer-on-stop nil)

  (prodigy-define-service
    :name "auth"
    :command (concat penneo-code-dir "api-auth/project-runner/run.sh")
    :args '("dev" "up")
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop nil)

  (prodigy-define-service
    :name "sign"
    :command (concat penneo-code-dir "Symfony2/project-runner/run.sh")
    :args '("dev" "up")
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop nil)

  (prodigy-define-service
    :name "workflows/forms"
    :command (concat penneo-code-dir "forms/project-runner/run.sh")
    :args '("dev" "up")
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop nil)

  (prodigy-define-service
    :name "pdf / eid"
    :command (concat penneo-code-dir "pdf-eid/project-runner/run.sh")
    :args '("dev" "up")
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop nil)

  (prodigy-define-service
    :name "validator"
    :command (concat penneo-code-dir "validator/project-runner/run.sh")
    :args '("dev" "up")
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop nil)

  (prodigy-define-service
    :name "sepior"
    :command (concat penneo-code-dir "SepiorService/project-runner/run.sh")
    :args '("dev" "up")
    :tags '(java)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop nil)

  )


;;; packages.el ends here
