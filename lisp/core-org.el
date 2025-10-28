;;; core-org.el --- Customizations for Org Mode -*- lexical-binding: t; -*-

;;; Commentary:
;;; All settings related to Org Mode live here.

;;; Code:

;; Automatically execute Emacs Lisp source blocks without confirmation.
;; This will still prompt for other languages like shell, python, etc.,
;; which is a good security practice.
(setq org-confirm-babel-evaluate (lambda (lang body) (not (string= lang "emacs-lisp"))))

;; Enable org-modern for cleaner, more aesthetically pleasing Org buffers.
(add-hook 'org-mode-hook #'org-modern-mode)
(diminish 'org-modern-mode)

(provide 'core-org)
;;; core-org.el ends here
