;; Read file content into a string
;; @see http://ergoemacs.org/emacs/elisp_read_file_content.html
;;
;;;###autoload
(defun util/get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

;;;###autoload
(defun util/insert-date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d.%m.%Y")
            (format-time-string "%Y-%m-%d"))))

;;;###autoload
(defun util/insert-date-time (arg)
  (interactive "P")
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))



;;;###autoload
(defun util/insert-empty-guid ()
  (interactive)
  (insert "00000000-0000-0000-0000-000000000000")
  )

;;;###autoload
(defun util/insert-my-guid ()
  (interactive)
  (insert "24242424-2424-2424-2424-242424242424"))

;;;###autoload
(defun util/make-executable ()
  (interactive)
  (shell-command (concat "chmod u+x " (shell-quote-argument buffer-file-name) " && echo Done!")))

;;;###autoload
(defun util/magit-status-yadm()
  "TODO: move to it's own package"
  (interactive)
  (magit-status "/yadm::")
  )

;; TODO: Move the following to a separate package for journals

;;;###autoload
(defun util/journal (title journal-dir)
  "Create a new journal entry with a given TITLE in a specified JOURNAL-DIR."
  (interactive "sTitle: \nDJournal Directory: ")
  ;; (org-journal-new-entry nil)
  ;; (insert title)
  ;; (org-clock-in)
  (let ((org-journal-dir journal-dir)
        (org-journal-file-format "%Y/%Y-%m-%d.org"))
    (org-journal-new-entry nil)))


;;;###autoload
(defun util/timelog ()
  "Main journal i.e. time log."
  (interactive)
  (util/journal "" "~/Journals/main"))

;;;###autoload
(defun util/reflect-journal ()
  "Personal reflections"
  (interactive)
  (util/journal "reflections" "~/Journals/reflections"))

;;;###autoload
(defun util/grephyte-journal ()
  "Journal for Grephyte"
  (interactive)
  (util/journal "journal : grephyte" "~/Journals/grephyte"))

;;;###autoload
(defun util/avallone-main-journal ()
  "Avallone journal"
  (interactive)
  (util/journal "journal : main" "~/Journals/avallone/main"))

;;;###autoload
(defun util/avallone-kristian-journal ()
  "Journal for Kristian at Avallone"
  (interactive)
  (util/journal "journal : kristian" "~/Journals/avallone/kristian"))

;;;###autoload
(defun util/avallone-thomas-f-journal ()
  "Journal for Thomas F at Avallone"
  (interactive)
  (util/journal "people : thomas" "~/Journals/avallone/thomas-f"))

;;;###autoload
(defun util/avallone-rihards-journal ()
  "Journal for Rihards at Avallone"
  (interactive)
  (util/journal "people : rihards" "~/Journals/avallone/rihards"))

;;;###autoload
(defun util/avallone-luke-journal ()
  "Journal for Luke at Avallone"
  (interactive)
  (util/journal "people : luke" "~/Journals/avallone/luke"))

;;;###autoload
(defun util/avallone-oksana-journal ()
  "Journal for Oksana at Avallone"
  (interactive)
  (util/journal "people : oksana" "~/Journals/avallone/oksana"))

;;;###autoload
(defun util/avallone-jesus-journal ()
  "Journal for Jesus at Avallone"
  (interactive)
  (util/journal "people : jesus" "~/Journals/avallone/jesus"))

;;;###autoload
(defun util/avallone-radu-journal ()
  "Journal for Radu at Avallone"
  (interactive)
  (util/journal "people : radu" "~/Journals/avallone/radu"))


;;;###autoload
(defun util/avallone-thaidan-td-journal ()
  "Journal for Anders at Avallone"
  (interactive)
  (util/journal "people : thaidan" "~/Journals/avallone/thaidan"))

;;;###autoload
(defun util/avallone-anders-journal ()
  "Journal for Anders at Avallone"
  (interactive)
  (util/journal "people : anders" "~/Journals/avallone/anders"))

;;;###autoload
(defun util/avallone-plan-journal ()
  "Journal for planning work at Avallone"
  (interactive)
  (util/journal "plan : " "~/Journals/avallone/plan"))

;;;###autoload
(defun util/pine-journal ()
  "Journal for pine"
  (interactive)
  (util/journal "pine : journal test" "~/Journals/pine")
  )

;; Scribbles
;; TODO: create a scribbles package

;;;###autoload
(defun scribble ()
  (interactive)
  (let* ((rel-path (format-time-string "%Y/%m/%d/"))
         (title (read-string "What do want to scribble about? "))
         (tags (read-string "Tags: "))
         (scribbles-path "~/.scribbles/")
         (scribble-file (concat scribbles-path rel-path (s-dashed-words title) ".rst"))
         (time (format-time-string "%b %d, %Y"))
         (underline (s-replace-regexp "." "=" title))
         )
    (find-file scribble-file)
    (unless (file-exists-p scribble-file)
      (insert title "\n" underline "\n\n" ".. post:: " time "\n   " ":tags: " tags "\n\n"))))

(provide 'util)
