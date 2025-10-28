;;; core-backups.el --- A sane backup strategy -*- lexical-binding: t; -*-

;;; Commentary:
;;; Stop Emacs from polluting project directories with backup files.
;;; We will centralize them in a single directory.

;;; Code:

(defconst user-emacs-backup-dir (expand-file-name "backups/" user-emacs-directory)
  "Central directory for all Emacs backup and auto-save files.")

;; Create the directory if it doesn't exist.
(make-directory user-emacs-backup-dir t)

;; Configure Emacs to use this central directory.
(setq backup-directory-alist `(("." . ,user-emacs-backup-dir)))
(setq auto-save-file-name-transforms `((".*" ,user-emacs-backup-dir t)))
(setq auto-save-list-file-prefix (concat user-emacs-backup-dir "auto-save-list"))
(setq tramp-backup-directory-alist backup-directory-alist) ;; For remote files too

;; Keep a reasonable number of versions.
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(provide 'core-backups)
;;; core-backups.el ends here
