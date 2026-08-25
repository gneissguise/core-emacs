;;; core-cheatsheet.el --- A custom cheat sheet viewer -*- lexical-binding: t; -*-

;;; Commentary:
;;; Defines a command to open our custom keybinding cheat sheets.

;;; Code:

(defun my-show-cheatsheet (sheet-name)
  "Find and display the cheat sheet file for SHEET-NAME."
  (interactive "sWhich cheatsheet? ")
  (let ((cheatsheet-file (expand-file-name (format "cheatsheets/%s.org" sheet-name)
                                           user-emacs-directory)))
    (if (file-exists-p cheatsheet-file)
        (find-file-other-window cheatsheet-file)
      (message "Cheat sheet '%s' not found at %s" sheet-name cheatsheet-file))))

(defun my-show-clojure-cheatsheet ()
  "Show the Clojure cheat sheet specifically."
  (interactive)
  (my-show-cheatsheet "clojure"))

(provide 'core-cheatsheet)
;;; core-cheatsheet.el ends here
